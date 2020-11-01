# frozen_string_literal: true

RSpec.describe Camper::Client::TodosAPI do
  before(:all) do
    @client = Camper.client
  end

  let(:test_class_todolist) { Struct.new(:todos_url) }
  let(:test_class_todo) { Struct.new(:url, :type) }

  context 'errors' do
    context '#todos' do
      it 'raises an error if todos_url field is not a valid basecamp url' do
        todolist = test_class_todolist.new('https://twitter.com')

        expect { @client.todos(todolist) }.to raise_error(Camper::Error::InvalidParameter)
      end
    end

    context '#create_todo' do
      it 'raises an error if todos_url field is not a valid basecamp url' do
        todolist = test_class_todolist.new('https://twitter.com')

        expect { @client.create_todo(todolist, 'Hello World') }.to raise_error(Camper::Error::InvalidParameter)
      end

      it 'raises an error if content parameter is blank' do
        todolist = test_class_todolist.new('https://3.basecamp.com/1234/todolists/1/todos.json')

        expect { @client.create_todo(todolist, '') }.to raise_error(Camper::Error::InvalidParameter)
      end
    end

    context '#update_todo' do
      it 'raises an error if todos_url field is not a valid basecamp url' do
        todo = test_class_todo.new('https://twitter.com')

        expect { @client.update_todo(todo, {}) }.to raise_error(Camper::Error::InvalidParameter)
      end
    end

    context '#complete_todo' do
      it 'raises an error if url field is not a valid basecamp url' do
        todo = test_class_todo.new('https://twitter.com')

        expect { @client.complete_todo(todo) }.to raise_error(Camper::Error::InvalidParameter)
      end
    end

    context '#uncomplete_todo' do
      it 'raises an error if url field is not a valid basecamp url' do
        todo = test_class_todo.new('https://twitter.com')

        expect { @client.uncomplete_todo(todo) }.to raise_error(Camper::Error::InvalidParameter)
      end
    end

    context '#reposition_todo' do
      it 'raises an error if url field is not a valid basecamp url' do
        todo = test_class_todo.new('https://twitter.com')

        expect { @client.reposition_todo(todo, 20) }.to raise_error(Camper::Error::InvalidParameter)
      end

      it 'raises an error if position param is less than 1' do
        todo = test_class_todo.new('https://3.basecamp.com/1234/projects')

        expect { @client.reposition_todo(todo, '0') }.to raise_error(Camper::Error::InvalidParameter)
      end
    end

    context '#trash_todo' do
      it 'raises an error if url field is not a valid basecamp url' do
        todo = test_class_todo.new('https://twitter.com')

        expect { @client.trash_todo(todo) }.to raise_error(Camper::Error::InvalidParameter)
      end

      it 'raises an error if type field is not a valid type' do
        todo = test_class_todo.new('https://3.basecamp.com/1234/projects', 'Project')

        expect { @client.trash_todo(todo) }.to raise_error(Camper::Error::InvalidParameter)
      end
    end
  end
end