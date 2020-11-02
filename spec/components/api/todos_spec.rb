# frozen_string_literal: true

RSpec.describe Camper::Client::TodosAPI do
  before(:all) do
    @client = Camper.configure do |config|
      config.access_token = 'access-token'
      config.account_number = '00000'
    end
  end

  context 'errors' do
    context '#todos' do
      it 'raises an error if todos_url field is not a valid basecamp url' do
        todolist = Camper::Resource.create({ todos_url: 'https://twitter.com' })

        expect { @client.todos(todolist) }.to raise_error(Camper::Error::InvalidURL)
      end
    end

    context '#create_todo' do
      it 'raises an error if todos_url field is not a valid basecamp url' do
        todolist = Camper::Resource.create({ todos_url: 'https://twitter.com' })

        expect { @client.create_todo(todolist, 'Hello World') }.to raise_error(Camper::Error::InvalidURL)
      end

      it 'raises an error if content parameter is blank' do
        todolist = Camper::Resource.create({
          url: 'https://3.basecamp.com/1234/todolists/1/todos.json'
        })

        expect { @client.create_todo(todolist, '') }.to raise_error(Camper::Error::InvalidParameter)
      end
    end

    context '#update_todo' do
      it 'raises an error if todos_url field is not a valid basecamp url' do
        todo = Camper::Resource.create({ url: 'https://twitter.com' })

        expect { @client.update_todo(todo, {}) }.to raise_error(Camper::Error::InvalidURL)
      end
    end

    context '#complete_todo' do
      it 'raises an error if url field is not a valid basecamp url' do
        todo = Camper::Resource.create({ url: 'https://twitter.com' })

        expect { @client.complete_todo(todo) }.to raise_error(Camper::Error::InvalidURL)
      end
    end

    context '#uncomplete_todo' do
      it 'raises an error if url field is not a valid basecamp url' do
        todo = Camper::Resource.create({ url: 'https://twitter.com' })

        expect { @client.uncomplete_todo(todo) }.to raise_error(Camper::Error::InvalidURL)
      end
    end

    context '#reposition_todo' do
      it 'raises an error if url field is not a valid basecamp url' do
        todo = Camper::Resource.create({ url: 'https://twitter.com' })

        expect { @client.reposition_todo(todo, 20) }.to raise_error(Camper::Error::InvalidURL)
      end

      it 'raises an error if position param is less than 1' do
        todo = Camper::Resource.create({ url: 'https://3.basecamp.com/1234/projects' })

        expect { @client.reposition_todo(todo, '0') }.to raise_error(Camper::Error::InvalidParameter)
      end
    end

    context '#trash_todo' do
      it 'raises an error if type field is not a valid type' do
        todo = Camper::Resource.create({
          url: 'https://3.basecamp.com/1234/projects',
          type: 'Project'
        })

        expect { @client.trash_todo(todo) }.to raise_error(Camper::Error::InvalidParameter)
      end
    end
  end
end