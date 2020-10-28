# camper ![CI](https://github.com/renehernandez/camper/workflows/CI/badge.svg) [![Gem Version](https://badge.fury.io/rb/camper.svg)](https://badge.fury.io/rb/camper)

Camper is a Ruby wrapper for the [Basecamp 3 API](https://github.com/basecamp/bc3-api).

You can check out the gem documentation at [https://www.rubydoc.org/gems/camper](https://www.rubydoc.org/gems/camper)

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

## Status of API endpoints

The up-to-date list of Basecamp API endpoints can be found at [here](https://github.com/basecamp/bc3-api#api-endpoints).

Currently, Camper supports the following endpoints:

* [Comments](https://github.com/basecamp/bc3-api/blob/master/sections/comments.md): Implementation at [comments.rb](https://github.com/renehernandez/camper/blob/main/lib/camper/api/comments.rb) (Partial)
* [Messages](https://github.com/basecamp/bc3-api/blob/master/sections/messages.md): Implementation at [messages.rb](https://github.com/renehernandez/camper/blob/main/lib/camper/api/messages.rb) (Partial)
* [People](https://github.com/basecamp/bc3-api/blob/master/sections/people.md): Implementation at [people.rb](https://github.com/renehernandez/camper/blob/main/lib/camper/api/people.rb) (Complete)
* [Projects](https://github.com/basecamp/bc3-api/blob/master/sections/projects.md): Implementation at [projects.rb](https://github.com/renehernandez/camper/blob/main/lib/camper/api/projects.rb) (Partial)
* [To-do list](https://github.com/basecamp/bc3-api/blob/master/sections/todolists.md): Implementation at [todolists.rb](https://github.com/renehernandez/camper/blob/main/lib/camper/api/todolists.rb) (Almost complete, only missing todolist trashing)
* [To-dos](https://github.com/basecamp/bc3-api/blob/master/sections/todos.md): Implementation at [todos.rb](https://github.com/renehernandez/camper/blob/main/lib/camper/api/todos.rb) (Almost complete, only missing todo trashing)

## Usage

### Configuration

Getting a `client` and configuring it:

```ruby
require 'camper'

client = Camper.client

client.configure do |config|
  config.client_id = 'client_id'
  config.client_secret = 'client_secret'
  config.account_number = 'account_number'
  config.refresh_token = 'refresh_token'
  config.access_token = 'access_token'
end
```

Alternatively, it is possible to invoke the top-level `#configure` method to get a `client`:

```ruby
require 'camper'

client = Camper.configure do |config|
  config.client_id = 'client_id'
  config.client_secret = 'client_secret'
  config.account_number = 'account_number'
  config.refresh_token = 'refresh_token'
  config.access_token = 'access_token'
end
```

Also, the `client` can read directly the following environment variables:

* `BASECAMP_CLIENT_ID`
* `BASECAMP_CLIENT_SECRET`
* `BASECAMP_ACCOUNT_NUMBER`
* `BASECAMP_REFRESH_TOKEN`
* `BASECAMP_ACCESS_TOKEN`

then the code would look like:

```ruby
require 'camper'

client = Camper.client
```


### Examples

Example getting list of TODOs:

```ruby
require 'camper'

client = Camper.configure do |config|
  config.client_id = ENV['BASECAMP_CLIENT_ID']
  config.client_secret = ENV['BASECAMP_CLIENT_SECRET']
  config.account_number = ENV['BASECAMP_ACCOUNT_NUMBER']
  config.refresh_token = ENV['BASECAMP_REFRESH_TOKEN']
  config.access_token = ENV['BASECAMP_ACCESS_TOKEN']
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
