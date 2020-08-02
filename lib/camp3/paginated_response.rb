# frozen_string_literal: true

module Camp3
  # Wrapper class of paginated response.
  class PaginatedResponse
    include Logging

    attr_accessor :client

    def initialize(array)
      @array = array
    end

    def ==(other)
      @array == other
    end

    def count
      @pagination_data.total_count
    end

    def inspect
      @array.inspect
    end

    def parse_headers!(headers)
      @pagination_data = PaginationData.new headers
      logger.debug("Pagination data: #{@pagination_data.inspect}")
    end

    def auto_paginate(limit = nil, &block)
      limit = self.count if limit.nil?
      return lazy_paginate.take(limit).to_a  unless block_given?

      lazy_paginate.take(limit).each(&block)
    end

    def next_page?
      !(@pagination_data.nil? || @pagination_data.next.nil?)
    end
    alias has_next_page? next_page?

    def next_page
      return nil if @client.nil? || !has_next_page?

      @client.get(client_relative_path(@pagination_data.next))
    end

    def method_missing(name, *args, &block)
      if @array.respond_to?(name)
        @array.send(name, *args, &block)
      else
        super
      end
    end

    def respond_to_missing?(method_name, include_private = false)
      super || @array.respond_to?(method_name, include_private)
    end

    private

    def lazy_paginate
      to_enum(:each_page).lazy.flat_map(&:to_ary)
    end

    def client_relative_path(link)
      client_endpoint_path = URI.parse(@client.api_endpoint).request_uri # api/v4
      URI.parse(link).request_uri.sub(client_endpoint_path, '')
    end

    def each_page
      current = self
      yield current
      while current.has_next_page?
        current = current.next_page
        yield current
      end
    end
  end
end