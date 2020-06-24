# frozen_string_literal: true

class Camp3::Client
  module Project

    def projects(options = {})
      get("/projects", options)
    end

    def message_board(project)
      board = project.dock.find { |payload| payload.name == 'message_board' }
      get(board.url, override_path: true)
    end

    def todoset(project)
      todoset = project.dock.find { |payload| payload.name == 'todoset' }
      get(todoset.url, override_path: true)
    end
  end
end