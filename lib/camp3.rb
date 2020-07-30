# frozen_string_literal: true

require 'forwardable'
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
  # Alias for Camp3::Client.new
  #
  # @return [Camp3::Client]
  def self.client(options = {})
    Camp3::Client.new(options)
  end

  # Delegates to Camp3::Client configure method
  #
  # @return [Camp3::Client]
  def self.configure(&block)
    self.client.configure(&block)
  end

end
