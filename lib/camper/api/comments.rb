# frozen_string_literal: true

module Camper
  class Client
    module CommentsAPI
      def create_comment(resource, content)
        raise Error::ResourceCannotBeCommented, resource unless resource.can_be_commented?

        post(resource.comments_url, override_path: true, body: { content: content })
      end

      def comments(resource)
        get(resource.comments_url, override_path: true)
      end
    end
  end
end