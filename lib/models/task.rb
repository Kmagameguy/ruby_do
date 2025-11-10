# frozen_string_literal: true

class Task < Sequel::Model
  def mark_complete!
    update(completed_at: Time.now)
  end

  def mark_incomplete!
    update(completed_at: nil)
  end

  def completed?
    !!completed_at
  end

  def date_completed(humanize: true)
    humanize ? humanize_date(completed_at) : completed_at
  end

  def date_created(humanize: true)
    humanize ? humanize_date(created_at) : created_at
  end

  def last_updated(humanize: true)
    humanize ? humanize_date(updated_at) : updated_at
  end

  def to_s
    "#{completed? ? '[x]' : '[ ]'} #{content}"
  end

  private

  def humanize_date(date)
    return unless date

    date.strftime("%b %e, %Y @ %l:%M%P")
  end
end
