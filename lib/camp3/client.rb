# frozen_string_literal: true

module Camp3
  # Wrapper for the Gitlab REST API.
  class Client < Request
    Dir[File.expand_path('resources/*.rb', __dir__)].each { |f| require f }
    
    # Keep in alphabetical order
    include Authorization
    include Project

    # @private
    attr_accessor(*Configuration::VALID_OPTIONS_KEYS)

    # Creates a new API.
    # @raise [Error:MissingCredentials]
    def initialize(options = {})
      options = Camp3.options.merge(options)
      
      (Configuration::VALID_OPTIONS_KEYS).each do |key|
        send("#{key}=", options[key]) if options[key]
      end

      self.class.headers 'User-Agent' => user_agent
    end

    # Text representation of the client, masking private token.
    #
    # @return [String]
    def inspect
      inspected = super
      inspected.sub! @access_token, only_show_last_four_chars(@access_token) if @access_token
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

    def only_show_last_four_chars(token)
      "#{'*' * (token.size - 4)}#{token[-4..-1]}"
    end
  end
end