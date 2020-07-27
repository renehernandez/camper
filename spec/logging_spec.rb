RSpec.describe Camp3::Logging do
  before do 
    @client = Camp3.client
  end
  
  it 'a client should have a default logger' do
    expect(@client.logger).to be_an_instance_of(Logger)
  end
end