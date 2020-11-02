# frozen_string_literal: true

module Camper
  class Client
    # Defines methods related to messages.
    # @see https://github.com/basecamp/bc3-api/blob/master/sections/messages.md
    module MessagesAPI
      # Get a paginated list of active messages under the given message board or project
      #
      # @example
      #   client.messages(message_board)
      # @example
      #   client.messages(my_project)
      #
      # @param parent [Project|Resource] either a project or message board resource
      # @return [PaginatedResponse<Resource>]
      # @see https://github.com/basecamp/bc3-api/blob/master/sections/messages.md#get-messages
      def messages(parent)
        if parent.is_a?(Project)
          bucket_id, board_id = parent.id, parent.message_board.id
        else
          bucket_id, board_id = parent.bucket.id, parent.id
        end

        get("/buckets/#{bucket_id}/message_boards/#{board_id}/messages")
      end

      # Get a paginated list of active messages under the given message board or project
      #
      # @example
      #   client.message(my_project, '2343')
      # @example
      #   client.message(message_board, 234)
      #
      # @param parent [Project|Resource] either a project or message board resource
      # @param message_id [Integer|String] id of the message to retrieve
      # @return [Resource]
      # @see https://github.com/basecamp/bc3-api/blob/master/sections/messages.md#get-a-message
      def message(parent, message_id)
        bucket_id = parent.is_a?(Project) ? parent.id : parent.bucket.id

        get("/buckets/#{bucket_id}/messages/#{message_id}")
      end

      # Create a message
      #
      # @example
      #   client.create_message(my_project, 'New Infrastructure')
      # @example
      #   client.create_message(message_board, 'New Launch',
      #     content: 'This launch will be awesome',
      #     category_id: '23'
      #   )
      #
      # @param parent [Project|Resource] either a project or message board resource
      # @param subject [String] subject of the new message
      # @param options [Hash] hash containing the content and/or category id for the new message
      # @return [Resource]
      # @see https://github.com/basecamp/bc3-api/blob/master/sections/messages.md#create-a-message
      def create_message(parent, subject, options = {})
        if parent.is_a?(Project)
          bucket_id, board_id = parent.id, parent.message_board.id
        else
          bucket_id, board_id = parent.bucket.id, parent.id
        end

        post(
          "/buckets/#{bucket_id}/message_boards/#{board_id}/messages",
          body: options.merge({ subject: subject, status: 'active' })
        )
      end

      # Update a message
      #
      # @example
      #   client.update_message(message, subject: 'New Infrastructure')
      # @example
      #   client.update_message(message, content: 'This launch will be awesome')
      # @example
      #   client.update_message(message, category_id: '6918641') # message type id
      #
      # @param message [Resource] message to update
      # @param options [Hash] subject of the new message
      # @param options [Hash] hash containing subject, content and/or category_id to update
      # @return [Resource]
      # @see https://github.com/basecamp/bc3-api/blob/master/sections/messages.md#update-a-message
      def update_message(message, options = {})
        raise Error::InvalidParameter, 'options cannot be empty' if options.empty?

        update("/buckets/#{message.bucket.id}/messages/#{message.id}", body: options)
      end

      # Trash message
      #   it calls the trash_recording endpoint under the hood
      #
      # @example
      #   client.trash_message(message)
      #
      # @param todo [Resource] the message to be trashed
      # @raise [Error::InvalidParameter] if url field in todo param
      #   is not a valid basecamp url
      # @see https://github.com/basecamp/bc3-api/blob/master/sections/recordings.md#trash-a-recording
      def trash_message(message)
        trash_recording(message)
      end
    end
  end
end