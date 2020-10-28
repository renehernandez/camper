# frozen_string_literal: true

class Camper::Client
  # Defines methods related to todos.
  # @see https://github.com/basecamp/bc3-api/blob/master/sections/todos.md
  module TodosAPI
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
    # @raise [Error::InvalidParameter] if todos_url field in todolist param
    #   is not a valid basecamp url
    # @see https://github.com/basecamp/bc3-api/blob/master/sections/todos.md#get-to-dos
    def todos(todolist, options = {})
      url = todolist.todos_url

      raise Camper::Error::InvalidParameter, todolist if !Camper::UrlUtils.basecamp_url?(url)

      get(url, options.merge(override_path: true))
    end

    # Get a todo with a given id using a particular parent resource.
    #
    # @example
    #   client.todo(my_project, '10')
    # @example
    #   client.todo(new_todolist, 134)
    # @example
    #   client.todo(67543, '2440')
    #
    # @param parent [Integer|String|Project|Resource] can be either a project id, a project or a todolist resource
    # @param id [Integer|String] id of the todo
    # @return [Resource]
    # @see https://github.com/basecamp/bc3-api/blob/master/sections/todos.md#get-a-to-do
    def todo(parent, id)
      bucket_id = parent

      if parent.is_a? Camper::Project
        bucket_id = parent.id
      elsif parent.respond_to?(:type)
        bucket_id = parent.bucket.id
      end

      get("/buckets/#{bucket_id}/todos/#{id}")
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
    # @raise [Error::InvalidParameter] if todos_url field in todolist param
    #   is not a valid basecamp url
    # @see https://github.com/basecamp/bc3-api/blob/master/sections/todos.md#create-a-to-do
    def create_todo(todolist, content, options = {})
      url = todolist.todos_url

      raise Camper::Error::InvalidParameter, todolist if !Camper::UrlUtils.basecamp_url?(url)

      post(url, body: { content: content, **options }, override_path: true)
    end

    # Complete a todo
    #
    # @example
    #   client.complete_todo(todo)
    #
    # @param todo [Resource] the todo to be marked as completed
    # @raise [Error::InvalidParameter] if url field in todo param
    #   is not a valid basecamp url
    # @see https://github.com/basecamp/bc3-api/blob/master/sections/todos.md#complete-a-to-do
    def complete_todo(todo)
      url = todo.url

      raise Camper::Error::InvalidParameter, todo if !Camper::UrlUtils.basecamp_url?(url)

      post("#{url}/completion", override_path: true)
    end

    # Uncomplete a todo
    #
    # @example
    #   client.uncomplete_todo(todo)
    #
    # @param todo [Resource] the todo to be marked as uncompleted
    # @raise [Error::InvalidParameter] if url field in todo param
    #   is not a valid basecamp url
    # @see https://github.com/basecamp/bc3-api/blob/master/sections/todos.md#uncomplete-a-to-do
    def uncomplete_todo(todo)
      url = todo.url

      raise Camper::Error::InvalidParameter, todo if !Camper::UrlUtils.basecamp_url?(url)

      delete("#{url}/completion", override_path: true)
    end

    # Reposition a todo
    #
    # @example
    #   client.uncomplete_todo(todo)
    #
    # @param todo [Resource] the todo to be repositioned
    # @param position [Integer|String] new position for the todo
    # @raise [Error::InvalidParameter] if url field in todo param
    #   is not a valid basecamp url
    # @raise [Error::InvalidParameter] if position param is less than 1
    # @see https://github.com/basecamp/bc3-api/blob/master/sections/todos.md#reposition-a-to-do
    def reposition_todo(todo, position)
      url = todo.url
      raise Camper::Error::InvalidParameter, todo if !Camper::UrlUtils.basecamp_url?(url)

      raise Camper::Error::InvalidParameter, position if position.to_i < 1

      put("#{url}/position", position: position, override_path: true)
    end
  end
end