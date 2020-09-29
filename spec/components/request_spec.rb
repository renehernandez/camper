# frozen_string_literal: true

RSpec.describe Camper::Request do
  before do
    @client = Camper.configure do |config|
      config.access_token = 'token'
      config.user_agent = 'user-agent'
    end
    @request = described_class.new(@client, :get, '/url/path')
  end

  describe '.default_options' do
    it 'has default values' do
      default_options = described_class.default_options
      expect(default_options).to be_a Hash
      expect(default_options[:format]).to eq(:json)
      expect(default_options[:headers]).to eq({ 'Accept' => 'application/json', 'Content-Type' => 'application/json', 'User-Agent' => 'user-agent' })
    end
  end

  describe '.parse' do
    it 'returns Resource' do
      body = JSON.unparse(a: 1, b: 2)
      expect(described_class.parse(body)).to be_an Camper::Resource
      expect(described_class.parse('true')).to be true
      expect(described_class.parse('false')).to be false
      expect { described_class.parse('string') }.to raise_error(Camper::Error::Parsing)
    end
  end

  describe '#authorization_header' do
    it 'raises MissingCredentials when access_token is not set' do
      request = described_class.new(Camper.client, :get, '/url/path')
      expect do
        request.send(:authorization_header)
      end.to raise_error(Camper::Error::MissingCredentials)
    end

    it 'sets the correct header when given a private_token' do
      expect(@request.send(:authorization_header)).to eq('Authorization' => 'Bearer token')
    end
  end
end