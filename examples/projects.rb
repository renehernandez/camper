require 'camper'

client = Camper.client

project = client.project(ENV['PROJECT_ID'])

puts "Project name: #{project.name}"
puts "Project description: #{project.description}"

client.update_project(project, name: 'Hermes Testing', description: 'Hermes integration testing')