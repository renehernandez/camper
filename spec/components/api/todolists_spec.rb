# frozen_string_literal: true

RSpec.describe Camper::Client::TodolistsAPI do
  before(:all) do
    @client = Camper.configure do |config|
      config.access_token = 'access-token'
      config.account_number = '00000'
    end
  end

  context 'errors' do
    context '#todolists' do
      it 'raises an error if todolists_url field is not a valid basecamp url' do
        todoset = Camper::Resource.create({ todolists_url: 'https://twitter.com' })

        expect { @client.todolists(todoset) }.to raise_error(Camper::Error::InvalidURL)
      end
    end

    context '#create_todolist' do
      it 'raises an error if todolists_url field is not a valid basecamp url' do
        todoset = Camper::Resource.create({ todolists_url: 'https://twitter.com' })

        expect { @client.create_todolist(todoset, 'Hello World') }.to raise_error(Camper::Error::InvalidURL)
      end
    end

    context '#update_todolist' do
      it 'raises an error if todolists_url field is not a valid basecamp url' do
        todolist = Camper::Resource.create({
          url: 'https://twitter.com',
          description: 'description'
        })

        expect { @client.update_todolist(todolist, 'Hello World') }.to raise_error(Camper::Error::InvalidURL)
      end
    end

    context '#trash_todolist' do
      it 'raises an error if type field is not a valid type' do
        todolist = Camper::Resource.create({
          url: 'https://twitter.com',
          type: 'Project'
        })

        expect { @client.trash_todolist(todolist) }.to raise_error(Camper::Error::InvalidParameter)
      end
    end
  end
end