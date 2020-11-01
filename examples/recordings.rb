require 'camper'

client = Camper.client

recordings = client.recordings(
  Camper::RecordingTypes::TODO
)

recordings.auto_paginate do |rec|
  puts "Comment content: #{rec.content}"
end