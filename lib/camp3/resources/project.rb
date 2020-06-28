module Camp3
  class Project < Resource

    attr_reader :message_board, :todoset, :schedule

    def initialize(hash)
      super

      @message_board = dock.find { |payload| payload.name == 'message_board' }
      @todoset = dock.find { |payload| payload.name == 'todoset' }
      @schedule = dock.find { |payload| payload.name == 'schedule' }
    end
  end
end