# frozen_string_literal: true

class Camper::Client
  module TodosAPI
    # Get the todolists associated with the todoset
    #
    # @example
    #   client.todolists(todoset)
    # @example
    #   client.todolists(todoset, status: 'archived')
    #
    # @param todoset [Resource] the parent todoset resource
    # @param options [Hash] extra options to filter the list of todolist
    # @return [Array<Resource>]
    # @see https://github.com/basecamp/bc3-api/blob/master/sections/todolists.md#get-to-do-lists
    def todolists(todoset, options = {})
      get(todoset.todolists_url, options.merge(override_path: true))
    end

    # Get a todolist with a given id
    #
    # @example
    #   client.todolist(todoset, '2345')
    #
    # @param todoset [Resource] the parent todoset resource
    # @param id [Integer, String] the id of the todolist to get
    # @return [Resource]
    # @see https://github.com/basecamp/bc3-api/blob/master/sections/todolists.md#get-a-to-do-list
    def todolist(todoset, id)
      get("/buckets/#{todoset.bucket.id}/todolists/#{id}")
    end

    # Get the todos in a todolist
    #
    # @example
    #   client.todos(todolist)
    # @example
    #   client.todos(todolist, completed: true)
    #
    # @param todolist [Resource] the parent todoset resource
    # @param options [Hash] options to filter the list of todos
    # @return [Resource]
    # @see https://github.com/basecamp/bc3-api/blob/master/sections/todos.md#get-to-dos
    def todos(todolist, options = {})
      get(todolist.todos_url, options.merge(override_path: true))
    end

    # Create a todo within a todolist
    #
    # @example
    #   client.create_todo(todolist, 'First Todo')
    # @example
    #   client.create_todo(
    #     todolist,
    #     'Program it',
    #     description: "<div><em>Try that new language!</em></div>, due_on: "2016-05-01"
    #   )
    #
    # @param todolist [Resource] the todolist where the todo is going to be created
    # @param content [String] what the to-do is for
    # @param options [Hash] extra configuration for the todo such as due_date and description
    # @return [Resource]
    # @see https://github.com/basecamp/bc3-api/blob/master/sections/todos.md#create-a-to-do
    def create_todo(todolist, content, options = {})
      post(todolist.todos_url, body: { content: content, **options }, override_path: true)
    end

    # Complete a todo
    #
    # @example
    #   client.complete_todo(todo)
    #
    # @param todo [Resource] the todo to be marked as completed
    # @see https://github.com/basecamp/bc3-api/blob/master/sections/todos.md#complete-a-to-do
    def complete_todo(todo)
      post("#{todo.url}/completion", override_path: true)
    end
  end
end