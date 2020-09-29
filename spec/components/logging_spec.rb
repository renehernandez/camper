# frozen_string_literal: true

RSpec.describe Camper::Logging do
  before do
    @client = Camper.client
  end

  it 'a client should have a default logger' do
    expect(@client.logger).to be_an_instance_of(Logger)
  end
end