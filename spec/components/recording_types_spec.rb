# frozen_string_literal: true

RSpec.describe Camper::RecordingTypes do
  it 'returns the correct list of valid recording types' do
    expect(Camper::RecordingTypes.all).to eql(
      %w[
        Comment
        Document
        Message
        Question::Answer
        Schedule::Entry
        Todo
        Todolist
        Upload
      ]
    )
  end
end