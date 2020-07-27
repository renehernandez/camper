# frozen_string_literal: true
require 'httparty'
require 'json'

module Camp3
  # @private
  class Request
    include HTTParty
    include Logging
    format :json
    headers 'Accept' => 'application/json'
    parser(proc { |body, _| parse(body) })

    module Result
      AccessTokenExpired = 'AccessTokenExpired'

      Valid = 'Valid'
    end

    def initialize(access_token, user_agent, client)
      @access_token = access_token
      @client = client

      self.class.headers 'User-Agent' => user_agent
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
      response ? JSON.load(response) : {}
    rescue JSON::ParserError
      raise Error::Parsing, 'The response is not a valid JSON'
    end

    %w[get post put delete].each do |method|
      define_method method do |path, options = {}|
        params = options.dup
        override_path = params.delete(:override_path)
        
        params[:headers] ||= {}

        full_endpoint = override_path ? path : @client.api_endpoint + path

        execute_request(method, full_endpoint, params)
      end
    end

    private

    # Executes the request
    def execute_request(method, endpoint, params)
      params[:headers].merge!(authorization_header)
      
      logger.debug("Method: #{method}; URL: #{endpoint}")
      response, result = validate self.class.send(method, endpoint, params)

      response = extract_parsed(response) if result == Result::Valid

      return response, result
    end

    # Checks the response code for common errors.
    # Informs that a retry needs to happen if request failed due to access token expiration
    # @raise [Error::ResponseError] if response is an HTTP error
    # @return [Response, Request::Result]
    def validate(response)
      error_klass = Error::STATUS_MAPPINGS[response.code]

      if error_klass == Error::Unauthorized && response.parsed_response.error.include?("OAuth token expired (old age)")
        logger.debug("Access token expired. Please obtain a new access token")
        return response, Result::AccessTokenExpired
      end

      raise error_klass, response if error_klass

      return response, Result::Valid
    end

    def extract_parsed(response)
      parsed = response.parsed_response
      
      parsed.client = self if parsed.respond_to?(:client=)
      parsed.parse_headers!(response.headers) if parsed.respond_to?(:parse_headers!)

      parsed
    end

    # Returns an Authorization header hash
    #
    # @raise [Error::MissingCredentials] if access_token and auth_token are not set.
    def authorization_header
      raise Error::MissingCredentials, 'Please provide a access_token' if @access_token.to_s.empty?

      { 'Authorization' => "Bearer #{@access_token}" }
    end
  end
end