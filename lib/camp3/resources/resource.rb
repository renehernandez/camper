# frozen_string_literal: true

class Camp3::Client
  module Resource
    
    def resource(url)
      get(url, override_path: true)
    end

  end
end