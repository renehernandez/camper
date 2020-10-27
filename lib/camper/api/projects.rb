# frozen_string_literal: true

class Camper::Client
  module ProjectsAPI
    def projects(options = {})
      get('/projects', options)
    end

    def project(id)
      get("/projects/#{id}")
    end

    def message_board(project)
      board = project.message_board
      get(board.url, override_path: true)
    end

    def todoset(project)
      todoset = project.todoset
      get(todoset.url, override_path: true)
    end
  end
end