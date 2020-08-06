# frozen_string_literal: true

module Camp3
  # Wrapper class of paginated response.
  class PaginatedResponse
    include Logging
    extend Forwardable

    def_delegators :@array, :to_ary, :first

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

      @client.get(@pagination_data.next, override_path: true)
    end

    private

    def lazy_paginate
      to_enum(:each_page).lazy.flat_map(&:to_ary)
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