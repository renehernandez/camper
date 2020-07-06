# frozen_string_literal: true

require 'rack/oauth2'

require "camp3/version"
require "camp3/logging"
require "camp3/error"
require "camp3/configuration"
require "camp3/authorization"
require "camp3/resource"
require "camp3/paginated_response"
require "camp3/page_links"
require "camp3/request"
require "camp3/client"

module Camp3
  extend Logging
  extend Configuration

  # def self.authorize!(auth_code)
  #   tokens = client.authorize!(auth_code)

  #   Resource.configure(Camp3.access_token)

  #   tokens
  # end

  # def self.update_access_token!(refresh_token = nil)
  #   refresh_token = Camp3.refresh_token unless refresh_token
    
  #   tokens = client.update_access_token!(refresh_token)

  #   Resource.configure(Camp3.access_token)

  #   tokens
  # end

  # def self.configure
  #   yield self

  #   Resource.configure(Camp3.access_token) if Camp3.access_token
  # end

  # Alias for Camp3::Client.new
  #
  # @return [Camp3::Client]
  def self.client(options = {})
    Camp3::Client.new(options)
  end

  # Delegate to Camp3::Client
  def self.method_missing(method, *args, &block)
    return super unless client.respond_to?(method)

    client.send(method, *args, &block)
  end

  # Delegate to Camp3::Client
  def self.respond_to_missing?(method_name, include_private = false)
    client.respond_to?(method_name) || super
  end

end
