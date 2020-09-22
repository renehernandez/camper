require 'camper'

client = Camper.configure do |config|
  config.client_id = ENV['BASECAMP3_CLIENT_ID']
  config.client_secret = ENV['BASECAMP3_CLIENT_SECRET']
  config.account_number = ENV['BASECAMP3_ACCOUNT_NUMBER']
  config.refresh_token = ENV['BASECAMP3_REFRESH_TOKEN']
end

tokens = client.update_access_token!

# Prints the new access token
puts tokens.access_token
