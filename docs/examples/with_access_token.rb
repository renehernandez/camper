require 'camp3'

Camp3.configure do |config|
    config.client_id = 'client_id'
    config.client_secret = 'client_secret'
    config.redirect_uri = 'redirect_uri'
    config.refresh_token = 'refresh_token'
    config.access_token = 'access_token'
end

messages = Camp3::Messages.all

