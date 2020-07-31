# frozen_string_literal: true

class Camp3::Client
  module CommentAPI
    def add_comment(resource, content)
      post(resource.comments_url, override_path: true, body: { content: content }.to_json)
    end

    def comments(resource)
      get(resource.comments_url, override_path: true)
    end
  end
end