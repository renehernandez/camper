# camper ![CI](https://github.com/renehernandez/camper/workflows/CI/badge.svg) [![Gem Version](https://badge.fury.io/rb/Camper.svg)](https://badge.fury.io/rb/camper)

Camper is a Ruby wrapper for the [Basecamp 3 API](https://github.com/basecamp/bc3-api).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'camper'
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install camper
```

## Usage

Getting a client and configuring it:

```ruby
require 'camper'

client = Camper.client

client.configure do |config|
  config.client_id = ENV['BASEcamper_CLIENT_ID']
  config.client_secret = ENV['BASEcamper_CLIENT_SECRET']
  config.account_number = ENV['BASEcamper_ACCOUNT_NUMBER']
  config.refresh_token = ENV['BASEcamper_REFRESH_TOKEN']
  config.access_token = ENV['BASEcamper_ACCESS_TOKEN']
end

projects = client.projects
```

Alternatively, it is possible to invoke the top-level `#configure` method to get a client:

```ruby
require 'camper'

client = Camper.configure do |config|
  config.client_id = ENV['BASEcamper_CLIENT_ID']
  config.client_secret = ENV['BASEcamper_CLIENT_SECRET']
  config.account_number = ENV['BASEcamper_ACCOUNT_NUMBER']
  config.refresh_token = ENV['BASEcamper_REFRESH_TOKEN']
  config.access_token = ENV['BASEcamper_ACCESS_TOKEN']
end

# gets a paginated response
projects = client.projects
```

Example getting list of TODOs:

```ruby
require 'camper'

client = Camper.configure do |config|
  config.client_id = ENV['BASEcamper_CLIENT_ID']
  config.client_secret = ENV['BASEcamper_CLIENT_SECRET']
  config.account_number = ENV['BASEcamper_ACCOUNT_NUMBER']
  config.refresh_token = ENV['BASEcamper_REFRESH_TOKEN']
  config.access_token = ENV['BASEcamper_ACCESS_TOKEN']
end

# gets a paginated response
projects = client.projects

# iterate all projects
projects.auto_paginate do |p|
  puts "Project: #{p.inspect}"

  puts "Todo set: #{p.todoset.inspect}"

  todoset = client.todoset(p)

  # iterate over the first 5 todo lists
  client.todolists(todoset).auto_paginate(5) do |list|
    puts "Todolist: #{list.title}"

    client.todos(list).auto_paginate do |todo|
      puts todo.inspect
    end
  end
end
```

For more examples, check out the [examples](examples/) folder

## Contributing

Check out the [Contributing](CONTRIBUTING.md) page.

## Changelog

For inspecting the changes and tag releases, check the [Changelog](CHANGELOG.md) page

## Appreciation

The gem code structure and documentation is based on the awesome [NARKOZ/gitlab gem](https://github.com/narkoz/gitlab)

## License

Checkout the [LICENSE](LICENSE) for details
