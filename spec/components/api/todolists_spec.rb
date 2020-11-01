# frozen_string_literal: true

RSpec.describe Camper::Client::TodolistsAPI do
  before(:all) do
    @client = Camper.client
  end

  let(:test_class_todoset) { Struct.new(:todolists_url) }
  let(:test_class_todolist) { Struct.new(:url, :type) }

  context 'errors' do
    context '#todolists' do
      it 'raises an error if todolists_url field is not a valid basecamp url' do
        todoset = test_class_todoset.new('https://twitter.com')

        expect { @client.todolists(todoset) }.to raise_error(Camper::Error::InvalidParameter)
      end
    end

    context '#create_todolist' do
      it 'raises an error if todolists_url field is not a valid basecamp url' do
        todoset = test_class_todoset.new('https://twitter.com')

        expect { @client.create_todolist(todoset, 'Hello World') }.to raise_error(Camper::Error::InvalidParameter)
      end
    end

    context '#update_todolist' do
      it 'raises an error if todolists_url field is not a valid basecamp url' do
        todolist = test_class_todolist.new('https://twitter.com')

        expect { @client.update_todolist(todolist, 'Hello World') }.to raise_error(Camper::Error::InvalidParameter)
      end
    end

    context '#trash_todolist' do
      it 'raises an error if type field is not a valid type' do
        todolist = test_class_todolist.new('https://3.basecamp.com/1234/projects', 'Project')

        expect { @client.trash_todolist(todolist) }.to raise_error(Camper::Error::InvalidParameter)
      end
    end
  end
end