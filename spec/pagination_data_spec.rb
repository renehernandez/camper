# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Camp3::PaginationData do
  before do
    @pagination_data = described_class.new('Link' => '<https://3.basecampapi.com/4379428/buckets/17149347/recordings/2680701090/comments.json?page=2>; rel="next"', "X-Total-Count" => 10)
  end

  describe '.extract_links' do
    it 'extracts link header appropriately' do
      expect(@pagination_data.next).to eql 'https://3.basecampapi.com/4379428/buckets/17149347/recordings/2680701090/comments.json?page=2'
      expect(@pagination_data.total_count).to eql 10
    end
  end
end