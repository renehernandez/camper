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
