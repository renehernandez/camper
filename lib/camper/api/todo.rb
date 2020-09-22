# frozen_string_literal: true

class Camper::Client
  module TodoAPI

    def todolists(todoset)
      get(todoset.todolists_url, override_path: true)
    end

    def todos(todolist, options={})
      get(todolist.todos_url, options.merge(override_path: true))
    end
  end
end