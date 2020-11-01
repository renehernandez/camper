# frozen_string_literal: true

module Camper
  class RecordingTypes

    COMMENT = 'Comment'
    DOCUMENT = 'Document'
    MESSAGE = 'Message'
    QUESTION_ANSWER = 'Question::Answer'
    SCHEDULE_ENTRY = 'Schedule::Entry'
    TODO = 'Todo'
    TODOLIST = 'Todolist'
    UPLOAD = 'Upload'

    # rubocop:disable Style/ClassVar
    def self.all 
      @@recordings ||= constants(false).map { |c| const_get(c) }.sort

      @@recordings
    end
    # rubocop:enable Style/ClassVar
  end
end