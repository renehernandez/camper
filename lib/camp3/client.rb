# frozen_string_literal: true

module Camp3
  # Wrapper for the Camp3 REST API.
  class Client
    Dir[File.expand_path('api/*.rb', __dir__)].each { |f| require f }

    extend Forwardable
    
    def_delegators :@config, *(Configuration::VALID_OPTIONS_KEYS)
    def_delegators :@config, :authz_endpoint, :token_endpoint, :api_endpoint, :base_api_endpoint

    # Keep in alphabetical order
    include Authorization
    include CommentAPI
    include Logging
    include MessageAPI
    include ProjectAPI
    include ResourceAPI
    include TodoAPI

    # Creates a new API.
    # @raise [Error:MissingCredentials]
    def initialize(options = {})
      @config = Configuration.new(options)
    end

    %w[get post put delete].each do |method|
      define_method method do |path, options = {}|
        response, result = new_request.send(method, path, options)
        return response unless result == Request::Result::AccessTokenExpired

        update_access_token!

        response, _ = new_request.send(method, path, options)
        response
      end
    end

    # Allows setting configuration values for this client
    # returns the client instance being configured
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

    # Utility method for URL encoding of a string.
    # Copied from https://ruby-doc.org/stdlib-2.7.0/libdoc/erb/rdoc/ERB/Util.html
    #
    # @return [String]
    def url_encode(url)
      url.to_s.b.gsub(/[^a-zA-Z0-9_\-.~]/n) { |m| sprintf('%%%02X', m.unpack1('C')) } # rubocop:disable Style/FormatString, Style/FormatStringToken
    end

    private

    def new_request
      Request.new(@config.access_token, @config.user_agent, self)
    end

    def only_show_last_four_chars(token)
      "#{'*' * (token.size - 4)}#{token[-4..-1]}"
    end

    # Utility method for transforming Basecamp Web URLs into API URIs
    # e.g 'https://3.basecamp.com/1/buckets/2/todos/3' will be 
    # converted into 'https://3.basecampapi.com/1/buckets/2/todos/3.json'
    #
    # @return [String]
    def url_transform(url)
      api_uri = url.gsub('3.basecamp.com', '3.basecampapi.com')
      api_uri += '.json' unless url.end_with? '.json'
      api_uri
    end
  end
end