# frozen_string_literal: true

require 'httparty'
require 'json'

module Camper
  class Request
    include HTTParty
    include Logging
    format :json
    headers 'Accept' => 'application/json', 'Content-Type' => 'application/json'
    parser(proc { |body, _| parse(body) })

    attr_reader :attempts

    MAX_RETRY_ATTEMPTS = 5

    module Result
      ACCESS_TOKEN_EXPIRED = 'AccessTokenExpired'

      TOO_MANY_REQUESTS = 'TooManyRequests'

      VALID = 'Valid'
    end

    def initialize(client, method, path, options = {})
      @client = client
      @path = path
      @options = options
      @attempts = 0
      @method = method

      self.class.headers 'User-Agent' => @client.user_agent
    end

    # Converts the response body to a Resource.
    def self.parse(body)
      body = decode(body)

      if body.is_a? Hash
        Resource.create(body)
      elsif body.is_a? Array
        PaginatedResponse.new(body.collect! { |e| Resource.create(e) })
      elsif body
        true
      elsif !body
        false
      elsif body.nil?
        false
      else
        raise Error::Parsing, "Couldn't parse a response body"
      end
    end

    # Decodes a JSON response into Ruby object.
    def self.decode(response)
      response ? JSON.parse(response) : {}
    rescue JSON::ParserError
      raise Error::Parsing, 'The response is not a valid JSON'
    end

    # Executes the request
    def execute
      endpoint, params = prepare_request_data

      raise Error::TooManyRetries, endpoint if maxed_attempts?

      @attempts += 1

      logger.debug("Method: #{@method}; URL: #{endpoint}")

      response, result = validate self.class.send(@method, endpoint, params)
      response = extract_parsed(response) if result == Result::VALID

      return response, result
    end

    def maxed_attempts?
      @attempts >= MAX_RETRY_ATTEMPTS
    end

    private

    def prepare_request_data
      params = @options.dup
      override_path = params.delete(:override_path)

      params[:body] = params[:body].to_json if body_to_json?(params)

      params[:headers] ||= {}
      params[:headers].merge!(self.class.headers)
      params[:headers].merge!(authorization_header)

      full_endpoint = override_path ? @path : @client.api_endpoint + @path

      full_endpoint = url_transform(full_endpoint)

      return full_endpoint, params
    end

    # Checks the response code for common errors.
    # Informs that a retry needs to happen if request failed due to access token expiration
    # @raise [Error::ResponseError] if response is an HTTP error
    # @return [Response, Request::Result]
    def validate(response)
      error_klass = Error::STATUS_MAPPINGS[response.code]

      if error_klass == Error::Unauthorized && response.parsed_response.error.include?('OAuth token expired (old age)')
        logger.debug('Access token expired. Please obtain a new access token')
        return response, Result::ACCESS_TOKEN_EXPIRED
      end

      if error_klass == Error::TooManyRequests
        logger.debug('Too many request. Please check the Retry-After header for subsequent requests')
        return response, Result::TOO_MANY_REQUESTS
      end

      raise error_klass, response if error_klass

      return response, Result::VALID
    end

    def extract_parsed(response)
      parsed = response.parsed_response

      parsed.client = @client if parsed.respond_to?(:client=)
      parsed.parse_headers!(response.headers) if parsed.respond_to?(:parse_headers!)

      parsed
    end

    # Returns an Authorization header hash
    #
    # @raise [Error::MissingCredentials] if access_token and auth_token are not set.
    def authorization_header
      raise Error::MissingCredentials, 'Please provide a access_token' if @client.access_token.to_s.empty?

      { 'Authorization' => "Bearer #{@client.access_token}" }
    end

    # Utility method for transforming Basecamp Web URLs into API URIs
    # e.g 'https://3.basecamp.com/1/buckets/2/todos/3' will be
    # converted into 'https://3.basecampapi.com/1/buckets/2/todos/3.json'
    #
    # @return [String]
    def url_transform(url)
      api_url = url.gsub('3.basecamp.com', '3.basecampapi.com')
      api_url.gsub!('.json', '')
      "#{api_url}.json"
    end

    def body_to_json?(params)
      @method == 'post' && params.key?(:body)
    end
  end
end