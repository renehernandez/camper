# frozen_string_literal: true

module Camp3
  # Parses link header.
  #
  # @private
  class PaginationData
    include Logging

    HEADER_LINK = 'Link'
    HEADER_TOTAL_COUNT = 'X-Total-Count'

    DELIM_LINKS = ','
    LINK_REGEX = /<([^>]+)>; rel="([^"]+)"/.freeze
    METAS = %w[next].freeze

    attr_accessor(*METAS)
    attr_accessor :total_count

    def initialize(headers)
      link_header = headers[HEADER_LINK]

      @total_count = headers[HEADER_TOTAL_COUNT].to_i

      extract_links(link_header) if link_header && link_header =~ /(next)/
    end

    def inspect
      "Next URL: #{@next}; Total Count: #{@total_count}"
    end

    private

    def extract_links(header)
      header.split(DELIM_LINKS).each do |link|
        LINK_REGEX.match(link.strip) do |match|
          url = match[1]
          meta = match[2]
          next if !url || !meta || METAS.index(meta).nil?

          send("#{meta}=", url)
        end
      end
    end
  end
end

