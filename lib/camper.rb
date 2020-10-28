# frozen_string_literal: true

require 'forwardable'
require 'rack/oauth2'

require 'camper/version'
require 'camper/logging'
require 'camper/error'
require 'camper/configuration'
require 'camper/url_utils'
require 'camper/authorization'
require 'camper/resource'
require 'camper/pagination_data'
require 'camper/paginated_response'
require 'camper/request'
require 'camper/client'

module Camper
  # Alias for Camper::Client.new
  #
  # @return [Camper::Client]
  def self.client(options = {})
    Camper::Client.new(options)
  end

  # Delegates to Camper::Client configure method
  #
  # @return [Camper::Client]
  def self.configure(&block)
    client.configure(&block)
  end

end
