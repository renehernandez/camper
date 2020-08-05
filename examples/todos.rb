require 'camp3'

client = Camp3.configure do |config|
  config.client_id = ENV['BASECAMP3_CLIENT_ID']
  config.client_secret = ENV['BASECAMP3_CLIENT_SECRET']
  config.account_number = ENV['BASECAMP3_ACCOUNT_NUMBER']
  config.refresh_token = ENV['BASECAMP3_REFRESH_TOKEN']
  config.access_token = ENV['BASECAMP3_ACCESS_TOKEN']
end

projects = client.projects

projects.auto_paginate do |p|
  puts "Project: #{p.inspect}"

  puts "Todo set: #{p.todoset.inspect}"

  todoset = client.todoset(p)

  client.todolists(todoset).auto_paginate do |list|
    puts "Todolist: #{list.title}"

    client.todos(list).auto_paginate do |todo|
      puts todo.inspect
    end
  end
end