RSpec.describe Camp3::Configuration do

  context 'using configure helper with all options' do
    before do
      Camp3.configure do |config|
        config.client_id = 'client_id'
        config.client_secret = 'client_secret'
        config.redirect_uri = 'redirect_uri'
        config.refresh_token = 'refresh_token'
        config.access_token = 'access_token'
        config.user_agent = 'user_agent'
      end
    end

    it "sets client_id" do
      expect(Camp3.client_id).to eq('client_id')
    end

    it "sets client_secret" do
      expect(Camp3.client_secret).to eq('client_secret')
    end

    it "sets redirect_uri" do
      expect(Camp3.redirect_uri).to eq('redirect_uri')
    end

    it "sets refresh_token" do
      expect(Camp3.refresh_token).to eq('refresh_token')
    end

    it "sets access_token" do
      expect(Camp3.access_token).to eq('access_token')
    end

    it "sets user_agent" do
      expect(Camp3.user_agent).to eq('user_agent')
    end
  end
end