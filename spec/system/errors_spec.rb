# frozen_string_literal: true

RSpec.describe Camper::Client do
  before do
    @client = Camper.configure do |config|
      config.client_id = 'client_id'
      config.client_secret = 'client_secret'
      config.account_number = 'account_number'
      config.refresh_token = 'refresh_token'
      config.access_token = 'access_token'
    end
  end

  it 'waits for Retry-After seconds to repeat the request' do
    response = double('response')
    allow(response).to receive(:code).and_return(429, 200)
    allow(response).to receive(:headers).and_return('Retry-After' => 1)
    allow(response).to receive(:parsed_response).and_return(response)

    request = Camper::Request.new(@client, :get, '/url/path')

    allow(request).to receive(:validate).and_return(
      [response, Camper::Request::Result::TOO_MANY_REQUESTS],
      [response, Camper::Request::Result::VALID]
    )
    allow(@client).to receive(:new_request).and_return(request)

    expect(@client.projects).to be response
  end

  it 'fails after going over the limit of requests attempts' do
    response = double('response')
    allow(response).to receive(:code).and_return(429)
    allow(response).to receive(:headers).and_return('Retry-After' => 1)

    request = Camper::Request.new(@client, :get, '/url/path')

    allow(request).to receive(:validate).and_return(
      [response, Camper::Request::Result::TOO_MANY_REQUESTS]
    )
    allow(@client).to receive(:new_request).and_return(request)

    expect { @client.projects }.to raise_error(Camper::Error::TooManyRetries)
  end
end