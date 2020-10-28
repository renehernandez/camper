# frozen_string_literal: true

RSpec.describe Camper::UrlUtils do
  context '.basecamp_url?' do
    it 'returns false if url param is empty' do
      expect(described_class.basecamp_url?('')).to be false
    end

    it 'returns false if url param is nil' do
      expect(described_class.basecamp_url?(nil)).to be false
    end

    it 'returns false if url param is not a url' do
      expect(described_class.basecamp_url?('hello world')).to be false
    end

    it 'returns false if url param is not a basecamp url' do
      expect(described_class.basecamp_url?('https://www.twiiter.com')).to be false
    end

    it 'returns true if url param is a basecamp url' do
      expect(described_class.basecamp_url?('https://3.basecamp.com/123456789/projects.json')).to be true
    end
  end

  context '.transform' do
    it 'transform a basecamp url into a basecampapi uri' do
      expect(described_class.transform('https://3.basecamp.com/1/projects.json')).to eq('https://3.basecampapi.com/1/projects.json')
    end

    it 'removes intermediate .json from url' do
      expect(described_class.transform('https://3.basecamp.com/1/projects.json/10')).to eq('https://3.basecampapi.com/1/projects/10.json')
    end
  end
end