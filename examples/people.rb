require 'camper'

client = Camper.client

current_user = client.profile

puts "Current User:\n#{current_user.inspect}"

