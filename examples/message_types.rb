# frozen_string_literal: true

require 'camper'

client = Camper.client

project = client.projects.first

puts 'List all messages types'
client.message_types(project).auto_paginate do |type|
  puts "Name: #{type.name}; Icon: #{type.icon}"
end

puts 'Create new message type'
type = client.create_message_type(project, 'Farewell', '👋')
puts "Message Type:\n#{type.inspect}"

puts 'Update message type name'
type = client.update_message_type(project, type, name: 'Bye bye')
puts "Message Type:\n#{type.inspect}"

puts 'Update message type icon'
type = client.update_message_type(project, type, icon: '🙌')
puts "Message Type:\n#{type.inspect}"

puts 'Delete message type'
client.delete_message_type(project, type)


