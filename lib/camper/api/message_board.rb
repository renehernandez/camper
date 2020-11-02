# frozen_string_literal: true

module Camper
  class Client
    # Defines methods related to message boards.
    # @see https://github.com/basecamp/bc3-api/blob/master/sections/message_boards.md
    module MessageBoardsAPI
      # Get a message board for a given project
      #
      # @example
      #   client.message_board(project)
      #
      # @param project [Project] project to get the associated message board on
      # @return [Resource]
      # @see https://github.com/basecamp/bc3-api/blob/master/sections/message_boards.md#message-boards
      def message_board(project)
        board = project.message_board

        get(board.url, override_path: true)
      end
    end
  end
end