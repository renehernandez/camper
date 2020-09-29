# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Camper::Resource do
  before do
    @hash = { a: 1, b: 2, 'string' => 'string', symbol: :symbol, array: ['string', { a: 1, b: 2 }] }
    @resource = described_class.new @hash
  end

  it 'resourcifies a hash' do
    expect(@resource.a).to eq(@hash[:a])
    expect(@resource.b).to eq(@hash[:b])
  end

  it 'resourcifies hashes contained in an array' do
    expect(@resource.array[1].a).to eq(@hash[:array][1][:a])
    expect(@resource.array[1].b).to eq(@hash[:array][1][:b])
    expect(@resource.array[0]).to eq(@hash[:array][0])
  end

  it 'supports legacy addressing mode' do
    expect(@resource['a']).to eq(@hash[:a])
    expect(@resource['b']).to eq(@hash[:b])
  end

  describe '#to_hash' do
    it 'returns an original hash' do
      expect(@resource.to_hash).to eq(@hash)
    end

    it 'has an alias #to_h' do
      expect(@resource).to respond_to(:to_h)
    end
  end

  describe '#inspect' do
    it 'returns a formatted string' do
      pretty_string = "#<#{@resource.class.name}:#{@resource.object_id} {hash: #{@hash}}"
      expect(@resource.inspect).to eq(pretty_string)
    end
  end

  describe '#respond_to' do
    it 'returns true for methods this object responds to through method_missing as sym' do
      expect(@resource).to respond_to(:a)
    end

    it 'returns true for methods this object responds to through method_missing as string' do
      expect(@resource).to respond_to('string')
    end

    it 'does not care if you use a string or symbol to reference a method' do
      expect(@resource).to respond_to(:string)
    end

    it 'does not care if you use a string or symbol to reference a method' do
      expect(@resource).to respond_to('symbol')
    end
  end
end