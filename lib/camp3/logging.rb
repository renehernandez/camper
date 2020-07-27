# frozen_string_literal: true

require 'logger'

module Camp3
  module Logging

    class << self
      attr_writer :logger
    end

    # @!attribute [rw] logger
    # @return [Logger] The logger.
    def logger
      @logger ||= default_logger
    end

    private

    # Create and configure a logger
    # @return [Logger]
    def default_logger
      logger = Logger.new($stdout)
      logger.level = ENV['BASECAMP3_LOG_LEVEL'] || Logger::WARN
      logger
    end
  end
end