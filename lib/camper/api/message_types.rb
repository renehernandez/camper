# frozen_string_literal: true

module Camper
  class Client
    # Defines methods related to message types.
    # @see https://github.com/basecamp/bc3-api/blob/master/sections/message_types.md
    module MessageTypesAPI
      # Get a paginated list of all messages types in a given project
      #
      # @example
      #   client.messages_types(my_project)
      #
      # @param project [Project] project to get the messages types from
      # @return [PaginatedResponse<Resource>]
      # @see https://github.com/basecamp/bc3-api/blob/master/sections/message_types.md#get-message-types
      def message_types(project)
        get("/buckets/#{project.id}/categories")
      end

      # Get a messages type in a given project
      #
      # @example
      #   client.message_type(my_project, '10')
      # @example
      #   client.message_type(my_project, 64926)
      #
      # @param project [Project] project to get the messages type from
      # @param message_type_id [Integer|String] id of the message type to retrieve
      # @return [Resource]
      # @see https://github.com/basecamp/bc3-api/blob/master/sections/message_types.md#get-a-message-type
      def message_type(project, message_type_id)
        get("/buckets/#{project.id}/categories/#{message_type_id}")
      end

      # Create a messages type in a given project
      #
      # @example
      #   client.create_message_type(my_project, 'Farewell', '👋')
      #
      # @param project [Project] project where the message type belongs to
      # @param name [String] name of the new message type
      # @param icon [String] icon to associate with the new message type
      # @return [Resource]
      # @raise [Error::InvalidParameter] if either name or icon is blank
      # @see https://github.com/basecamp/bc3-api/blob/master/sections/message_types.md#create-a-message-type
      def create_message_type(project, name, icon)
        raise Error::InvalidParameter, 'Name and icon parameters cannot be blank' if name.blank? || icon.blank?

        post("/buckets/#{project.id}/categories", body: { name: name, icon: icon })
      end

      # Update a message type in a given project
      #
      # @example
      #   client.update_message_type(my_project, type, name: 'Quick Update')
      # @example
      #   client.update_message_type(my_project, type, icon: '🤙')
      #
      # @param project [Project] project where the message type belongs to
      # @param type [Resource|Integer|String] resource or id representing a message type
      # @param options [Hash] hash containing the name and/or icon to modify
      # @return [Resource]
      # @raise [Error::InvalidParameter] if options parameter is empty
      # @see https://github.com/basecamp/bc3-api/blob/master/sections/message_types.md#destroy-a-message-type
      def update_message_type(project, type, options = {})
        raise Error::InvalidParameter, 'options cannot be empty' if options.empty?

        type_id = type.respond_to?(:id) ? type.id : type

        put("/buckets/#{project.id}/categories/#{type_id}", body: options)
      end

      # Delete a message type in a given project
      #
      # @example
      #   client.delete_message_type(my_project, type)
      #
      # @param project [Project] project where the message type belongs to
      # @param type [Resource|Integer|String] resource or id representing a message type
      # @see https://github.com/basecamp/bc3-api/blob/master/sections/message_types.md#destroy-a-message-type
      def delete_message_type(project, type)
        type_id = type.respond_to?(:id) ? type.id : type

        delete("/buckets/#{project.id}/categories/#{type_id}")
      end

      alias trash_message_type delete_message_type
    end
  end
end