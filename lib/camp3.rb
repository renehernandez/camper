require 'active_resource'
require 'rack/oauth2'


require "camp3/version"
require "camp3/logging"
require "camp3/error"
require "camp3/configuration"
require "camp3/authorization"
require "camp3/client"


module Camp3
  extend Logging
  extend Configuration

  # Alias for Camp3::Client.new
  #
  # @return [Camp3::Client]
  def self.client(options = {})
    puts "Creating new client: <options: #{options}"
    Camp3::Client.new(options)
  end

  # Delegate to Camp3::Client
  def self.method_missing(method, *args, &block)
    logger.debug "Method missing: <method: #{method}>; <args: #{args}>; <block: #{block}>"
    return super unless client.respond_to?(method)

    logger.debug "Didn't call super method"
    client.send(method, *args, &block)
  end

  # Delegate to Camp3::Client
  def self.respond_to_missing?(method_name, include_private = false)
    logger.debug "Respond to missing: <method_name: #{method_name}>; <include_private: #{include_private}>"
    client.respond_to?(method_name) || super
  end

end
