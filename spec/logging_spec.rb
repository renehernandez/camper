RSpec.describe Camp3::Logging do
  it 'should have a default logger' do
    expect(Camp3.logger).to be_an_instance_of(Logger)
  end
end