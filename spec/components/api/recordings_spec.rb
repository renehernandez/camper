# frozen_string_literal: true

RSpec.describe Camper::Client::RecordingsAPI do
  before(:all) do
    @client = Camper.client
  end

  let(:test_class_recordings) { Struct.new(:type) }

  context 'errors' do
    context '#recordings' do
      it 'raises an error if type is not part of the allowed ones' do
        expect { @client.recordings('User') }.to raise_error(Camper::Error::InvalidParameter)
      end
    end

    context '#trash_recording' do
      it 'raises an error if type is not part of the allowed ones' do
        resource = test_class_recordings.new('todoset')
        expect { @client.trash_recording(resource) }.to raise_error(Camper::Error::InvalidParameter)
      end
    end

    context '#archive_recording' do
      it 'raises an error if type is not part of the allowed ones' do
        resource = test_class_recordings.new('todoset')
        expect { @client.archive_recording(resource) }.to raise_error(Camper::Error::InvalidParameter)
      end
    end

    context '#unarchive_recording' do
      it 'raises an error if type is not part of the allowed ones' do
        resource = test_class_recordings.new('todoset')
        expect { @client.unarchive_recording(resource) }.to raise_error(Camper::Error::InvalidParameter)
      end
    end
  end
end