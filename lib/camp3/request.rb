# frozen_string_literal: true
require 'httparty'
require 'json'

module Camp3
  # @private
  class Request
    include HTTParty
    format :plain
    headers 'Accept' => 'application/json'

    attr_accessor :access_token

    # Converts the response body to an ObjectifiedHash.
    def self.parse(body)
      Camp3.logger.debug "Parsing body: #{body.class}"
      body = decode(body)

      if body.is_a? Hash
        ObjectifiedHash.new body
      elsif body.is_a? Array
        PaginatedResponse.new(body.collect! { |e| ObjectifiedHash.new(e) })
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

    %w[get post put delete].each do |method|
      define_method method do |path, options = {}|
        override_path = options.delete(:override_path)
        params = options.dup

        params[:headers] ||= {}
        params[:headers].merge!(authorization_header)

        full_endpoint = override_path ? path : Camp3.api_endpoint + path

        validate self.class.send(method, full_endpoint, params)
      end
    end

    # Checks the response code for common errors.
    # Returns parsed response for successful requests.
    def validate(response)
      error_klass = Error::STATUS_MAPPINGS[response.code]
      raise error_klass, response if error_klass

      parsed = self.class.parse(response)
      parsed.client = self if parsed.respond_to?(:client=)
      parsed.parse_headers!(response.headers) if parsed.respond_to?(:parse_headers!)
      parsed
    end

    private

    # Returns an Authorization header hash
    #
    # @raise [Error::MissingCredentials] if access_token and auth_token are not set.
    def authorization_header
      raise Error::MissingCredentials, 'Please provide a access_token' unless @access_token

      { 'Authorization' => "Bearer #{@access_token}" }
    end
  end
end