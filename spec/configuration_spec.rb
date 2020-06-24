RSpec.describe Camp3::Configuration do

  context 'using configure helper with all options' do
    before do
      Camp3.configure do |config|
        config.client_id = 'client_id'
        config.client_secret = 'client_secret'
        config.redirect_uri = 'redirect_uri'
        config.account_number = '000000'
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

    it "sets the account number" do
      expect(Camp3.account_number).to eq('000000')
    end

    it 'sets the fixed authz endpoint' do 
      expect(Camp3.authz_endpoint).to eq('https://launchpad.37signals.com/authorization/new')
    end

    it 'sets the fixed token endpoint' do 
      expect(Camp3.token_endpoint).to eq('https://launchpad.37signals.com/authorization/token')
    end

    it 'sets the fixed api endpoint' do 
      expect(Camp3.api_endpoint).to eq('https://3.basecampapi.com/000000')
    end
  end
end