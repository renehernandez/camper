# frozen_string_literal: true

class Camper::Client
  module MessageAPI
    def messages(message_board)
      get(message_board.messages_url, override_path: true)
    end
  end
end