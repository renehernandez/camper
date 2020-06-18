# frozen_string_literal: true

module Camp3
  # Defines constants and methods related to configuration.
  module Configuration
    include Logging

    # An array of valid keys in the options hash when configuring a Basecamp::API.
    VALID_OPTIONS_KEYS = %i[
      client_id 
      client_secret 
      redirect_uri 
      refresh_token 
      access_token 
      user_agent
    ].freeze

    # The user agent that will be sent to the API endpoint if none is set.
    DEFAULT_USER_AGENT = "Camp3 Ruby Gem #{Camp3::VERSION}"

    # @private
    attr_accessor(*VALID_OPTIONS_KEYS)

    # Sets all configuration options to their default values
    # when this module is extended.
    def self.extended(base)
      base.reset
    end

    # Convenience method to allow configuration options to be set in a block.
    def configure
      yield self
    end

    # Creates a hash of options and their values.
    def options
      logger.debug "Create options hash from attr_accessors"
      VALID_OPTIONS_KEYS.inject({}) do |option, key|
        option.merge!(key => send(key))
      end
    end

    # Resets all configuration options to the defaults.
    def reset
      logger.debug "Resetting attributes to default environment values"
      self.client_id      = ENV['BASECAMP3_CLIENT_ID']
      self.client_secret  = ENV['BASECAMP3_CLIENT_SECRET']
      self.redirect_uri   = ENV['BASECAMP3_REDIRECT_URI']
      self.refresh_token  = ENV['BASECAMP3_REFRESH_TOKEN']
      self.access_token   = ENV['BASECAMP3_ACCESS_TOKEN']
      self.user_agent     = ENV['BASECAMP3_USER_AGENT'] || DEFAULT_USER_AGENT
    end

    def auth_endpoint
      'https://launchpad.37signals.com/authorization/new'
    end

    def token_endpoint
      'https://launchpad.37signals.com/authorization/token'
    end

    def api_endpoint
      'https://3.basecampapi.com'
    end
  end
end