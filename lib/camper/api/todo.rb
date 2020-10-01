# frozen_string_literal: true

class Camper::Client
  module TodoAPI

    def todolists(todoset)
      get(todoset.todolists_url, override_path: true)
    end

    def todolist(todoset, id)
      get("/buckets/#{todoset.bucket.id}/todolists/#{id}")
    end

    def todos(todolist, options={})
      get(todolist.todos_url, options.merge(override_path: true))
    end

    def create_todo(todolist, content, options={})
      post(todolist.todos_url, body: {content: content, **options}, override_path: true)
    end

    def complete_todo(todo)
      post("#{todo.url}/completion", override_path: true)
    end
  end
end