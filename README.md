# camp3 ![CI](https://github.com/renehernandez/camp3/workflows/CI/badge.svg) [![Gem Version](https://badge.fury.io/rb/camp3.svg)](https://badge.fury.io/rb/camp3)

Camp3 is a Ruby wrapper for the [Basecamp 3 API](https://github.com/basecamp/bc3-api).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'camp3'
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install camp3
```

## Usage

Configuration example:

```ruby
require 'camp3'

Camp3.configure do |config|
  config.client_id = ENV['BASECAMP3_CLIENT_ID']
  config.client_secret = ENV['BASECAMP3_CLIENT_SECRET']
  config.account_number = ENV['BASECAMP3_ACCOUNT_NUMBER']
  config.refresh_token = ENV['BASECAMP3_REFRESH_TOKEN']
  config.access_token = ENV['BASECAMP3_ACCESS_TOKEN']
end
```

For more complex examples, we recommend using a client, instead of the top level `Camp3` wrapper. A `client` has a builtin mechanism to retry requests when the access token has expired and update its information (so it will use the new access token instead of the old one), as oppose to the top level `Camp3` which would request a new access token every time a request were to be made.

```ruby
require 'camp3'

Camp3.configure do |config|
  config.client_id = ENV['BASECAMP3_CLIENT_ID']
  config.client_secret = ENV['BASECAMP3_CLIENT_SECRET']
  config.account_number = ENV['BASECAMP3_ACCOUNT_NUMBER']
  config.refresh_token = ENV['BASECAMP3_REFRESH_TOKEN']
  config.access_token = ENV['BASECAMP3_ACCESS_TOKEN']
end

client = Camp3.client

projects = client.projects

projects.each do |p|
  puts "Project: #{p.inspect}"

  puts "Todo set: #{p.todoset.inspect}"

  todoset = client.todoset(p)

  client.todolists(todoset).each do |list|
    puts "Todolist: #{list.title}"

    client.todos(list).each do |todo|
      puts todo.inspect
    end
  end
end
```

For more examples, check the [examples](examples/) folder

## Contributing

Check out the [Contributing](CONTRIBUTING.md) page.

## Changelog

For inspecting the changes and tag releases, check the [Changelog](CHANGELOG.md) page

## Appreciation

The gem code structure and documentation is based on the awesome [NARKOZ/gitlab gem](https://github.com/narkoz/gitlab)

## License

Checkout the [LICENSE](LICENSE) for details
