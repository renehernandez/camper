# frozen_string_literal: true

require_relative 'lib/camper/version'

Gem::Specification.new do |spec|
  spec.name          = 'camper'
  spec.version       = Camper::VERSION
  spec.authors       = ['renehernandez']

  spec.summary       = 'Ruby client for Basecamp 3 API'
  spec.homepage      = 'https://github.com/renehernandez/camper'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.5.0')
  spec.license       = 'MIT'

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'httparty', '~> 0.18'
  spec.add_dependency 'rack-oauth2', '~> 1.14'
  spec.add_dependency 'concurrent-ruby', '~> 1.1'

  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.9'
  spec.add_development_dependency 'yard', '~> 0.9'
end
