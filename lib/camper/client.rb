# frozen_string_literal: true

module Camper
  # Wrapper for the Camper REST API.
  class Client
    Dir[File.expand_path('api/*.rb', __dir__)].each { |f| require f }

    extend Forwardable

    def_delegators :@config, *(Configuration::VALID_OPTIONS_KEYS)
    def_delegators :@config, :authz_endpoint, :token_endpoint, :api_endpoint, :base_api_endpoint

    # Keep in alphabetical order
    include Authorization
    include CommentsAPI
    include Logging
    include MessagesAPI
    include PeopleAPI
    include ProjectsAPI
    include ResourceAPI
    include TodolistsAPI
    include TodosAPI

    # Creates a new Client instance.
    # @raise [Error:MissingCredentials]
    def initialize(options = {})
      @config = Configuration.new(options)
    end

    %w[get post put delete].each do |method|
      define_method method do |path, options = {}|
        request = new_request(method, path, options)

        loop do
          response, result = request.execute
          logger.debug("Request result: #{result}; Attempt: #{request.attempts}")
          return response unless retry_request?(response, result)
        end
      end
    end

    # Allows setting configuration values for this client
    # by yielding the config object to the block
    # @return [Camper::Client] the client instance being configured
    def configure
      yield @config

      self
    end

    # Text representation of the client, masking private token.
    #
    # @return [String]
    def inspect
      inspected = super
      inspected.sub! @config.access_token, only_show_last_four_chars(@config.access_token) if @config.access_token
      inspected
    end

    private

    def new_request(method, path, options)
      Request.new(self, method, path, options)
    end

    def retry_request?(response, result)
      case result
      when Request::Result::ACCESS_TOKEN_EXPIRED
        update_access_token!
        true
      when Request::Result::TOO_MANY_REQUESTS
        sleep_before_retrying(response)
        true
      else
        false
      end
    end

    def sleep_before_retrying(response)
      time = response.headers['Retry-After'].to_i
      logger.debug("Sleeping for #{time} seconds before retrying request")

      sleep(time)
    end

    def only_show_last_four_chars(token)
      "#{'*' * (token.size - 4)}#{token[-4..-1]}"
    end
  end
end