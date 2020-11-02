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
  todoset = client.todoset(p)

  # Message board and Todo set are example resources that doesn't have comments
  puts "Message Board: #{message_board.title}, can be commented on: #{message_board.can_be_commented?}"
  puts "Todo set: #{todoset.title}, can be commented on: #{todoset.can_be_commented?}"

  # Adds a comment on the first todolist
  list = client.todolists(todoset).first
  puts "Todolist: #{list.title}, can be commented on: #{list.can_be_commented?}"

  puts 'Create a new comment'
  new_comment = client.create_comment(list, 'New temporary comment')
  comments = client.comments(list)
  idx = 0
  comments.auto_paginate do |c|
    puts "Comment #{idx} content: #{c.content}"
    idx += 1
  end

  puts 'Get single comment'
  single_comment = client.comment(list, new_comment.id)

  puts 'Update comment'
  client.update_comment(single_comment, 'New content')

  puts 'Delete comment'
  client.trash_comment(single_comment)
end
