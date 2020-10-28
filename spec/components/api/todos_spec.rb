RSpec.describe Camper::Client::TodosAPI do
  before(:all) do
    @client = Camper.client

    TodosAPI_TestTodolist = Struct.new(:todos_url)
    TodosAPI_TestTodo = Struct.new(:url)
  end

  context 'errors' do
    context '#todos' do
      it 'raises an error if todos_url field is not a valid basecamp url' do
        todolist = TodosAPI_TestTodolist.new('https://twitter.com')

        expect{ @client.todos(todolist) }.to raise_error(Camper::Error::InvalidParameter)
      end
    end

    context '#create_todo' do
      it 'raises an error if todos_url field is not a valid basecamp url' do
        todolist = TodosAPI_TestTodolist.new('https://twitter.com')

        expect{ @client.create_todo(todolist, 'Hello World') }.to raise_error(Camper::Error::InvalidParameter)
      end
    end

    context '#complete_todo' do
      it 'raises an error if url field is not a valid basecamp url' do
        todo = TodosAPI_TestTodo.new('https://twitter.com')

        expect{ @client.complete_todo(todo) }.to raise_error(Camper::Error::InvalidParameter)
      end
    end

    context '#uncomplete_todo' do
      it 'raises an error if url field is not a valid basecamp url' do
        todo = TodosAPI_TestTodo.new('https://twitter.com')

        expect{ @client.uncomplete_todo(todo) }.to raise_error(Camper::Error::InvalidParameter)
      end
    end

    context '#reposition_todo' do
      it 'raises an error if url field is not a valid basecamp url' do
        todo = TodosAPI_TestTodo.new('https://twitter.com')

        expect{ @client.reposition_todo(todo, 20) }.to raise_error(Camper::Error::InvalidParameter)
      end

      it 'raises an error if position param is less than 1' do
        todo = TodosAPI_TestTodo.new('https://3.basecamp.com/1234/projects')

        expect{ @client.reposition_todo(todo, '0') }.to raise_error(Camper::Error::InvalidParameter)
      end
    end
  end
end