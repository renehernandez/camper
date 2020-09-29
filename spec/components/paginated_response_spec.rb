# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Camper::PaginatedResponse do
  before do
    array = [1, 2, 3, 4]
    @paginated_response = described_class.new array
  end

  it 'responds to next_page and has_next_page methods' do
    expect(@paginated_response).to respond_to :next_page
    expect(@paginated_response).to respond_to :has_next_page?
  end

  describe '.parse_headers!' do
    it 'parses headers' do
      next_url = 'https://3.basecampapi.com/000000/buckets/11111111/recordings/2222222222/comments.json?page=2'
      @paginated_response.parse_headers!('Link' => "<#{next_url}>; rel=\"next\"", 'X-Total-Count' => 10)
      client = @paginated_response.client = double('client')
      next_page_response = double('next_page_response')

      allow(client).to receive(:get).with(next_url, override_path: true).and_return(next_page_response)

      expect(@paginated_response.has_next_page?).to be true
      expect(@paginated_response.next_page).to be next_page_response
    end
  end

  describe '.auto_paginate' do
    it 'returns an array if block is not given' do
      next_page = double('next_page')
      allow(@paginated_response).to receive(:count).and_return(8)
      allow(@paginated_response).to receive(:has_next_page?).and_return(true)
      allow(@paginated_response).to receive(:next_page).and_return(next_page)
      # allow(next_page).to receive(:has_next_page?).and_return(false)
      allow(next_page).to receive(:to_ary).and_return([5, 6, 7, 8])
      expect(@paginated_response.auto_paginate).to contain_exactly(1, 2, 3, 4, 5, 6, 7, 8)
    end
  end

  describe '#auto_paginate' do
    it 'only requests needed pages' do
      next_page_response = double('next_page')
      allow(@paginated_response).to receive(:has_next_page?).and_return(true)
      allow(@paginated_response).to receive(:next_page).and_return(next_page_response)
      allow(next_page_response).to receive(:has_next_page?).and_return(true)
      # NOTE:
      # Do not define :next_page on the next_page double to prove that it is NOT
      # called even though :has_next_page? has been defined to claim another
      # page is available.
      allow(next_page_response).to receive(:to_ary).and_return([5, 6, 7, 8])
      expect(@paginated_response.auto_paginate(8)).to contain_exactly(1, 2, 3, 4, 5, 6, 7, 8)
    end

    context 'when performing autopagination returning an array' do
      before do
        next_page = double('next_page')
        allow(@paginated_response).to receive(:has_next_page?).and_return(true)
        allow(@paginated_response).to receive(:next_page).and_return(next_page)
        allow(next_page).to receive(:has_next_page?).and_return(false)
        allow(next_page).to receive(:to_ary).and_return([5, 6, 7, 8])
      end

      it 'returns a limited array' do
        expect(@paginated_response.auto_paginate(3)).to contain_exactly(1, 2, 3)
      end

      it 'returns exactly the first page' do
        expect(@paginated_response.auto_paginate(4)).to contain_exactly(1, 2, 3, 4)
      end

      it 'returns a page plus one' do
        next_page = double('next_page')
        allow(@paginated_response).to receive(:has_next_page?).and_return(true)
        allow(@paginated_response).to receive(:next_page).and_return(next_page)
        allow(next_page).to receive(:has_next_page?).and_return(false)
        allow(next_page).to receive(:to_ary).and_return([5])
        expect(@paginated_response.auto_paginate(5)).to contain_exactly(1, 2, 3, 4, 5)
      end
    end

    context 'when performing limited pagination with a block' do
      before do
        next_page = double('next_page')
        allow(@paginated_response).to receive(:has_next_page?).and_return(true)
        allow(@paginated_response).to receive(:next_page).and_return(next_page)
        allow(next_page).to receive(:has_next_page?).and_return(false)
        allow(next_page).to receive(:to_ary).and_return([5, 6, 7, 8])
      end

      it 'iterates items with limit' do
        expect { |b| @paginated_response.auto_paginate(3, &b) }.to yield_successive_args(1, 2, 3)
      end

      it 'iterates exactly the first page' do
        expect { |b| @paginated_response.auto_paginate(4, &b) }.to yield_successive_args(1, 2, 3, 4)
      end

      it 'iterates the first page plus one' do
        expect { |b| @paginated_response.auto_paginate(5, &b) }.to yield_successive_args(1, 2, 3, 4, 5)
      end
    end
  end
end