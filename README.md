# camp3 ![CI](https://github.com/renehernandez/camp3/workflows/CI/badge.svg) [![Gem Version](https://badge.fury.io/rb/camp3.svg)](https://badge.fury.io/rb/camp3)

Camp3 is a Ruby wrapper for the [Basecamp 3 API](https://github.com/basecamp/bc3-api)

TODO: Delete this and the text above, and describe your gem

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

Example getting list of TODOs

```ruby
require 'camp3'

Camp3.configure do |config|
  config.client_id = ENV['BASECAMP3_CLIENT_ID']
  config.client_secret = ENV['BASECAMP3_CLIENT_SECRET']
  config.account_number = ENV['BASECAMP3_ACCOUNT_NUMBER']
  config.refresh_token = ENV['BASECAMP3_REFRESH_TOKEN']
  config.access_token = ENV['BASECAMP3_ACCESS_TOKEN']
end

projects = Camp3.projects

projects.each do |p|
  puts "Project: #{p.inspect}"

  puts "Todo set: #{p.todoset.inspect}"

  todoset = Camp3.todoset(p)

  Camp3.todolists(todoset).each do |list|
    puts "Todolist: #{list.title}"

    Camp3.todos(list).each do |todo|
      puts todo.inspect
    end
  end
end
```

## License

Checkout the [LICENSE](LICENSE) for details
