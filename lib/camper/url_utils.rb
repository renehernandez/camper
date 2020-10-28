# frozen_string_literal: true

module Camper
  # Defines methods related to url operations.
  module UrlUtils
    def self.basecamp_url?(url)
      return false if url.nil? || !url.is_a?(String) || url == ''

      transformed_url = UrlUtils.transform(url)

      transformed_url.match?(%r{#{Configuration.base_api_endpoint}/\d+/.*})
    end

    # Utility method for transforming Basecamp Web URLs into API URIs
    # e.g 'https://3.basecamp.com/1/buckets/2/todos/3' will be
    # converted into 'https://3.basecampapi.com/1/buckets/2/todos/3.json'
    #
    # @param url [String] url to test
    # @return [String]
    def self.transform(url)
      api_url = url.gsub('3.basecamp.com', '3.basecampapi.com')
      api_url.gsub!('.json', '')
      "#{api_url}.json"
    end
  end
end