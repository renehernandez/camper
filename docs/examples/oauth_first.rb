require 'camp3'

Camp3.configure do |config|
    config.client_id = 'client_id'
    config.client_secret = 'client_secret'
    config.redirect_uri = 'redirect_uri'
end

# This will update the configuration with the corresponding tokens
token = Camp3.authorize! auth_code

