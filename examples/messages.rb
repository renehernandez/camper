# frozen_string_literal: true

require 'camper'

client = Camper.configure do |config|
  config.client_id = ENV['BASECAMP3_CLIENT_ID']
  config.client_secret = ENV['BASECAMP3_CLIENT_SECRET']
  config.account_number = ENV['BASECAMP3_ACCOUNT_NUMBER']
  config.refresh_token = ENV['BASECAMP3_REFRESH_TOKEN']
  config.access_token = ENV['BASECAMP3_ACCESS_TOKEN']
end

projects = client.projects

projects.auto_paginate do |p|
  puts "Project: #{p.name}"

  message_board = client.message_board(p)
  puts "Message Board: #{message_board.title}"

  puts 'List messages using the message board'
  messages = client.messages(message_board)

  messages.auto_paginate do |msg|
    puts "Title: #{msg.title}; Content: #{msg.content}"
  end

  puts 'List messages using the project'
  messages = client.messages(p)

  messages.auto_paginate do |msg|
    puts "Title: #{msg.title}; Content: #{msg.content}"
    puts "Message:\n#{msg.inspect}"
  end
end
