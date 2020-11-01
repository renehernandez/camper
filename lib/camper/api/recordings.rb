# frozen_string_literal: true

module Camper
  class Client
    # Defines methods related to recordings.
    # @see https://github.com/basecamp/bc3-api/blob/master/sections/recordings.md
    module RecordingsAPI
      # Get a paginated response of recordings of a given type
      #
      # @example
      #   client.recordings('Todo')
      # @example
      #   client.recordings(
      #     'Document',
      #     bucket: [1,2],
      #     status: 'archived',
      #     sort: 'updated_at',
      #     direction: 'asc'
      #   )
      #
      # @param type [String] type of the recording
      # @param options [Hash] extra options to filter the recordings to be resulted
      # @return [PaginatedResponse<Resource>]
      # @raise [Error::InvalidParameter] if type is not one of the allowed types
      # @see https://github.com/basecamp/bc3-api/blob/master/sections/recordings.md#get-recordings
      def recordings(type, options = {})
        raise Error::InvalidParameter, type unless RecordingTypes.all.include?(type)

        get('/projects/recordings', query: options.merge(type: type))
      end

      # Trash a given recording
      #
      # @example
      #   client.trash_recording(my_todo)
      # @example
      #   client.trash_recording(my_message)
      #
      # @param recording [Resource] a resource of a valid recording type
      # @raise [Error::InvalidParameter] if type field in recording param
      #   is not one of the allowed types
      # @see https://github.com/basecamp/bc3-api/blob/master/sections/recordings.md#trash-a-recording
      def trash_recording(recording)
        raise Error::InvalidParameter, recording unless RecordingTypes.all.include?(recording.type)

        put("/buckets/#{recording.bucket.id}/recordings/#{recording.id}/status/trashed")
      end

      # Archive a given recording
      #
      # @example
      #   client.archive_recording(my_todo)
      # @example
      #   client.archive_recording(my_message)
      #
      # @param recording [Resource] a resource of a valid recording type
      # @raise [Error::InvalidParameter] if type field in recording param
      #   is not one of the allowed types
      # @see https://github.com/basecamp/bc3-api/blob/master/sections/recordings.md#archive-a-recording
      def archive_recording(recording)
        raise Error::InvalidParameter, recording unless RecordingTypes.all.include?(recording.type)

        put("/buckets/#{recording.bucket.id}/recordings/#{recording.id}/status/archived")
      end

      # Unarchive a given recording
      #
      # @example
      #   client.unarchive_recording(my_todo)
      # @example
      #   client.unarchive_recording(my_message)
      #
      # @param recording [Resource] a resource of a valid recording type
      # @raise [Error::InvalidParameter] if type field in recording param
      #   is not one of the allowed types
      # @see https://github.com/basecamp/bc3-api/blob/master/sections/recordings.md#unarchive-a-recording
      def unarchive_recording(recording)
        raise Error::InvalidParameter, recording unless RecordingTypes.all.include?(recording.type)

        put("/buckets/#{recording.bucket.id}/recordings/#{recording.id}/status/active")
      end
    end
  end
end