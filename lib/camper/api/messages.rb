# frozen_string_literal: true

module Camper
  class Client
    module MessagesAPI
      def messages(message_board)
        get(message_board.messages_url, override_path: true)
      end
    end
  end
end