RSpec.describe Camp3 do
  it "has a version number" do
    expect(Camp3::VERSION).not_to be nil
  end

  describe '#client' do 
    it 'is a Camp3::Client' do
      expect(described_class.client).to be_a Camp3::Client
    end

    it 'does not override each other' do
      client1 = described_class.client(
        client_id: 'client1', 
        client_secret: 'secret1', 
        account_number: '1',
        refresh_token: 'refresh1'
      )
      client2 = described_class.client(
        client_id: 'client2', 
        client_secret: 'secret2', 
        account_number: '2',
        refresh_token: 'refresh2'
      )

      expect(client1.api_endpoint).to eq('https://3.basecampapi.com/1')
      expect(client2.api_endpoint).to eq('https://3.basecampapi.com/2')
      expect(client1.refresh_token).to eq('refresh1')
      expect(client2.refresh_token).to eq('refresh2')
    end
  end

  describe '#configure' do
    it 'returns a Camp3::Client' do
      expect(described_class.configure {}).to be_a Camp3::Client
    end
  end
end
