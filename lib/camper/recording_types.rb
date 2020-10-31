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


    def self.all
      @@recordings ||= self.constants(false).map{ |c| self.const_get(c) }.sort

      @@recordings
    end
  end
end