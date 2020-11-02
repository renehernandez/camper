# frozen_string_literal: true

RSpec.describe Camper::Client::MessagesAPI do
  before(:all) do
    @client = Camper.client
  end

  context 'errors' do
    context '#update_message' do
      it 'raises an error if the options parameter is empty' do
        resource = Camper::Resource.create({ url: 'https://3.basecampapi.com' })

        expect { @client.update_message(resource, {}) }.to raise_error(Camper::Error::InvalidParameter)
      end
    end
  end
end