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
  puts "Project: #{p.name}"

  message_board = Camp3.message_board(p)
  puts "Message Board: #{message_board.title}"

  messages = Camp3.messages(message_board)

  messages.each do |msg|
    puts msg.inspect
  end
end