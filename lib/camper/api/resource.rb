# frozen_string_literal: true

class Camper::Client
  module ResourceAPI

    def resource(url)
      get(url_transform(url), override_path: true)
    end

  end
end