# frozen_string_literal: true

module ToDo
  class Task
    attr_accessor :content

    def initialize(content:)
      @content      = content
      @created_at   = Time.now
      @completed_at = nil
    end

    def created_at(humanize: true)
      humanize ? humanize_date(@created_at) : @created_at
    end

    def completed_at(humanize: true)
      humanize ? humanize_date(@completed_at)  : @completed_at
    end

    def mark_complete!
      @completed_at = Time.now
    end

    def mark_incomplete!
      @completed_at = nil
    end

    def completed?
      !!@completed_at
    end

    def to_s
      "#{completed? ? "[x]" : "[ ]"} #{content}"
    end

    private
    
    def humanize_date(date)
      return unless date

      date.strftime("%b %e, %Y @ %l:%M%P")
    end
  end
end

