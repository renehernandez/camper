require 'camper'

client = Camper.client

recordings = client.recordings(
  Camper::RecordingTypes::TODO
)

recordings.auto_paginate do |rec|
  puts "Todo content: #{rec.content}"
end