module Camp3
  class Resource < ObjectifiedHash

    Dir[File.expand_path('resources/*.rb', __dir__)].each { |f| require f }

    def self.create(hash)
      klass = detect_type(hash["url"])

      return klass.new(hash)
    end

    def self.detect_type(url)
      Camp3.logger.debug "Request URL: #{url}" 
      case url
      when /#{Camp3.api_endpoint}\/projects\/\d+\.json/
        return Project
      else
        return Resource
      end
    end
  end
end