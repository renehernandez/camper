# frozen_string_literal: true

RSpec.describe Camper::Client::CommentsAPI do
  before(:all) do
    @client = Camper.client
  end

  context 'errors' do
    context '#comments' do
      it 'raises an error if the resource cannot be commented on' do
        resource = Camper::Resource.create({ url: 'https://3.basecampapi.com' })

        expect { @client.comments(resource) }.to raise_error(Camper::Error::ResourceCannotBeCommented)
      end
    end

    context '#comment' do
      it 'raises an error if the resource cannot be commented on' do
        resource = Camper::Resource.create({ url: 'https://3.basecampapi.com' })

        expect { @client.comment(resource, 10) }.to raise_error(Camper::Error::ResourceCannotBeCommented)
      end
    end

    context '#create_comment' do
      it 'raises an error if the resource cannot be commented on' do
        resource = Camper::Resource.create({ url: 'https://3.basecampapi.com' })

        expect { @client.create_comment(resource, 'Hello World') }.to raise_error(Camper::Error::ResourceCannotBeCommented)
      end
    end
  end
end