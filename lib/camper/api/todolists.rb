# frozen_string_literal: true

class Camper::Client
  # Defines methods related to todolists.
  # @see https://github.com/basecamp/bc3-api/blob/master/sections/todolists.md
  module TodolistsAPI
    # Get the todolists associated with the todoset
    #
    # @example
    #   client.todolists(todoset)
    # @example
    #   client.todolists(todoset, status: 'archived')
    #
    # @param todoset [Resource] the parent todoset resource
    # @param options [Hash] extra options to filter the list of todolist
    # @return [PaginatedResponse<Resource>]
    # @raise [Error::InvalidParameter] if todolists_url field in todoset param
    #   is not a valid basecamp url
    # @see https://github.com/basecamp/bc3-api/blob/master/sections/todolists.md#get-to-do-lists
    def todolists(todoset, options = {})
      url = todoset.todolists_url

      raise Camper::Error::InvalidParameter, todoset unless Camper::UrlUtils.basecamp_url?(url)

      get(url, query: options, override_path: true)
    end

    # Get a todolist with a given id
    #
    # @example
    #   client.todolist(todoset, '2345')
    #
    # @param todoset [Resource] the parent todoset resource
    # @param id [Integer, String] the id of the todolist to get
    # @return [Resource]
    # @see https://github.com/basecamp/bc3-api/blob/master/sections/todolists.md#get-a-to-do-list
    def todolist(todoset, id)
      get("/buckets/#{todoset.bucket.id}/todolists/#{id}")
    end

    # Create a todolist within the given todoset
    #
    # @example
    #   client.create_todolist(todoset, 'Launch', "<div><em>Finish it!</em></div>")
    #
    # @param todoset [Resource] the parent todoset resource
    # @param name [String] the name of the new todolist
    # @param description [String] an optional description for the todolist
    # @return [Resource]
    # @raise [Error::InvalidParameter] if todolists_url field in todoset param
    #   is not a valid basecamp url
    # @see https://github.com/basecamp/bc3-api/blob/master/sections/todolists.md#create-a-to-do-list
    def create_todolist(todoset, name, description = '')
      url = todoset.todolists_url

      raise Camper::Error::InvalidParameter, todoset unless Camper::UrlUtils.basecamp_url?(url)

      post(url, body: { name: name, description: description }, override_path: true)
    end

    # Update a todolist to change name and description
    #
    # @example
    #   client.update_todolist(todolist, 'Launch', "<div><em>Finish it!</em></div>")
    #
    # @param todolist [Resource] the todolist resource to update
    # @param name [String] the new name of the todolist
    # @param description [String] a new optional description for the todolist
    # @return [Resource]
    # @raise [Error::InvalidParameter] if url field in todolist param
    #   is not a valid basecamp url
    # @see https://github.com/basecamp/bc3-api/blob/master/sections/todolists.md#update-a-to-do-list
    def update_todolist(todolist, name, description = '')
      url = todolist.url

      raise Camper::Error::InvalidParameter, todolist unless Camper::UrlUtils.basecamp_url?(url)

      put(url, body: { name: name, description: description }, override_path: true)
    end

    # Trash a todolist
    #   it calls the trash_recording endpoint under the hood
    #
    # @example
    #   client.trash_todolist(todolist)
    #
    # @param todolist [Resource] the todolist to be trashed
    # @raise [Error::InvalidParameter] if the type field in todolist param
    #   is not an allowed type in the recording API
    # @see https://github.com/basecamp/bc3-api/blob/master/sections/recordings.md#trash-a-recording
    def trash_todolist(todolist)
      trash_recording(todolist)
    end
  end
end