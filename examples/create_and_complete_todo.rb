require 'camper'

# It will configure the client using the basecamp environment variables
client = Camper.client

project = client.project(ENV['PROJECT_ID'])

todoset = client.todoset(project)

todolist = client.todolist(todoset, ENV['TODOLIST_ID'])

puts todolist.title

client.todos(todolist).auto_paginate do |todo|
  puts todo.title
end

todo = client.create_todo(todolist, 'TODO from camper', description: 'This is a todo created with camper')

puts todo.title

client.complete_todo(todo)