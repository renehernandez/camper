# frozen_string_literal: true

module Camper
  class Client
    # Defines methods related to comments.
    # @see https://github.com/basecamp/bc3-api/blob/master/sections/comments.md
    module CommentsAPI
      # Get a paginated list of active comments for a given resource
      #
      # @example
      #   client.comments(todo)
      #
      # @param resource [Resource] resource to gets the comments from
      # @return [PaginatedResponse<Resource>]
      # @raise [Error::ResourceCannotBeCommented] if the resource doesn't support comments
      # @see https://github.com/basecamp/bc3-api/blob/master/sections/comments.md#get-comments
      def comments(resource)
        raise Error::ResourceCannotBeCommented, resource unless resource.can_be_commented?

        get(resource.comments_url, override_path: true)
      end

      # Get a comment within a resource
      #
      # @example
      #   client.comment(todo, 10)
      # @example
      #   client.comment(my_message, '23')
      #
      # @param resource [Resource] resource to get the comment from
      # @param comment_id [Integer|String] id of comment ot retrieve
      # @return [Resource]
      # @raise [Error::ResourceCannotBeCommented] if the resource doesn't support comments
      # @see https://github.com/basecamp/bc3-api/blob/master/sections/comments.md#get-a-comment
      def comment(resource, comment_id)
        raise Error::ResourceCannotBeCommented, resource unless resource.can_be_commented?

        bucket_id = resource.bucket.id

        get("/buckets/#{bucket_id}/comments/#{comment_id}")
      end

      # Create a new comment for a given resource
      #
      # @example
      #   client.create_comment(my_message, 'We are ready to start the project')
      #
      # @param resource [Resource] resource to create the comment on
      # @param content [String] content of the comment
      # @return [Resource]
      # @raise [Error::ResourceCannotBeCommented] if the resource doesn't support comments
      # @see https://github.com/basecamp/bc3-api/blob/master/sections/comments.md#create-a-comment
      def create_comment(resource, content)
        raise Error::ResourceCannotBeCommented, resource unless resource.can_be_commented?

        post(resource.comments_url, override_path: true, body: { content: content })
      end

      # Update the content in a comment
      #
      # @example
      #   client.update_comment(comment, 'Fixed grammar mistakes')
      #
      # @param comment [Resource] comment to modify
      # @param content [String] new content of the comment
      # @return [Resource]
      # @see https://github.com/basecamp/bc3-api/blob/master/sections/comments.md#update-a-comment
      def update_comment(comment, content)
        bucket_id = comment.bucket.id

        put("/buckets/#{bucket_id}/comments/#{comment.id}", body: { content: content })
      end

      # Trash a comment
      #   it calls the trash_recording endpoint under the hood
      #
      # @example
      #   client.trash_comment(current_comment)
      #
      # @param comment [Resource] the comment to be trashed
      # @see https://github.com/basecamp/bc3-api/blob/master/sections/recordings.md#trash-a-recording
      def trash_comment(comment)
        trash_recording(comment)
      end
    end
  end
end