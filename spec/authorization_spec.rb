RSpec.describe Camp3::Authorization do
  before do
    @client = Camp3.configure do |config|
      config.client_id = 'client_id'
      config.client_secret = 'client_secret'
      config.redirect_uri = 'redirect_uri'
      config.user_agent = 'user_agent'
    end
  end

  it 'creates authz uri' do
    uri = @client.authorization_uri

    expected_uri = 'https://launchpad.37signals.com/authorization/new?'
    expected_uri += 'client_id=client_id&redirect_uri=redirect_uri&response_type=code&type=web_server'
    expect(uri).to eq(expected_uri)
  end
end