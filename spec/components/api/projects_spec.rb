# frozen_string_literal: true

RSpec.describe Camper::Client::ProjectsAPI do
  before(:all) do
    @client = Camper.client
  end

  context 'errors' do
    context '#create_project' do
      it 'raises an error if name field is blank' do
        expect { @client.create_project('') }.to raise_error(Camper::Error::InvalidParameter)
        expect { @client.create_project(nil, 'Hello World') }.to raise_error(Camper::Error::InvalidParameter)
      end
    end

    context '#update_project' do
      it 'raises an error if name and description field are both blank' do
        expect { @client.update_project(10) }.to raise_error(Camper::Error::InvalidParameter)
      end
    end
  end
end