# frozen_string_literal: true

RSpec.describe Camper::Client::MessageTypesAPI do
  before(:all) do
    @client = Camper.client
  end

  context 'errors' do
    context '#create_message_type' do
      it 'raises an error if the name and icon are blank' do
        resource = Camper::Resource.create({ url: 'https://3.basecampapi.com' })

        expect { @client.create_message_type(resource, '', '') }.to raise_error(Camper::Error::InvalidParameter)
      end
    end

    context '#update_message_type' do
      it 'raises an error if options parameter is empty' do
        resource = Camper::Resource.create({ url: 'https://3.basecampapi.com' })

        expect { @client.update_message_type(resource, {}) }.to raise_error(Camper::Error::InvalidParameter)
      end
    end
  end
end