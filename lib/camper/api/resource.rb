# frozen_string_literal: true

module Camper
  class Client
    module ResourceAPI
      def resource(url)
        get(url, override_path: true)
      end
    end
  end
end