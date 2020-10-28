RSpec.describe Camper::Client::TodolistsAPI do
  before(:all) do
    @client = Camper.client

    TodolistsAPI_TestTodoset = Struct.new(:todolists_url)
    TodolistsAPI_TestTodolist = Struct.new(:url)
  end

  context 'errors' do
    context '#todolists' do
      it 'raises an error if todolists_url field is not a valid basecamp url' do
        todoset = TodolistsAPI_TestTodoset.new('https://twitter.com')

        expect{ @client.todolists(todoset) }.to raise_error(Camper::Error::InvalidParameter)
      end
    end

    context '#create_todolist' do
      it 'raises an error if todolists_url field is not a valid basecamp url' do
        todoset = TodolistsAPI_TestTodoset.new('https://twitter.com')

        expect{ @client.create_todolist(todoset, 'Hello World') }.to raise_error(Camper::Error::InvalidParameter)
      end
    end

    context '#update_todolist' do
      it 'raises an error if todolists_url field is not a valid basecamp url' do
        todolist = TodolistsAPI_TestTodolist.new('https://twitter.com')

        expect{ @client.update_todolist(todolist, 'Hello World') }.to raise_error(Camper::Error::InvalidParameter)
      end
    end
  end
end