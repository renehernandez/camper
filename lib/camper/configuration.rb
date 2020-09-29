# frozen_string_literal: true

module Camper
  # Defines constants and methods related to configuration.
  class Configuration
    include Logging

    # An array of valid keys in the options hash when configuring a Basecamp::API.
    VALID_OPTIONS_KEYS = %i[
      client_id
      client_secret
      redirect_uri
      account_number
      refresh_token 
      access_token
      user_agent
    ].freeze

    # The user agent that will be sent to the API endpoint if none is set.
    DEFAULT_USER_AGENT = "Camper Ruby Gem #{Camper::VERSION}"

    # @private
    attr_accessor(*VALID_OPTIONS_KEYS)

    def initialize(options = {})
      default_from_environment
      VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key]) if options[key]
      end
    end

    # Creates a hash of options and their values.
    def options
      VALID_OPTIONS_KEYS.inject({}) do |option, key|
        option.merge!(key => send(key))
      end
    end

    # rubocop:disable Metrics/AbcSize
    # Resets all configuration options to the defaults.
    def default_from_environment
      logger.debug 'Setting attributes to default environment values'
      self.client_id      = ENV['BASECAMP3_CLIENT_ID']
      self.client_secret  = ENV['BASECAMP3_CLIENT_SECRET']
      self.redirect_uri   = ENV['BASECAMP3_REDIRECT_URI']
      self.account_number = ENV['BASECAMP3_ACCOUNT_NUMBER']
      self.refresh_token  = ENV['BASECAMP3_REFRESH_TOKEN']
      self.access_token   = ENV['BASECAMP3_ACCESS_TOKEN']
      self.user_agent     = ENV['BASECAMP3_USER_AGENT'] || DEFAULT_USER_AGENT
    end
    # rubocop:enable Metrics/AbcSize

    def authz_endpoint
      'https://launchpad.37signals.com/authorization/new'
    end

    def token_endpoint
      'https://launchpad.37signals.com/authorization/token'
    end

    def api_endpoint
      raise Camper::Error::InvalidConfiguration, "missing basecamp account" unless self.account_number

      "#{self.base_api_endpoint}/#{self.account_number}"
    end

    def base_api_endpoint
      self.class.base_api_endpoint
    end

    def self.base_api_endpoint
      "https://3.basecampapi.com"
    end
  end
end