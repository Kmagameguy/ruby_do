# frozen_string_literal: true

class TaskManager
  def self.open!
    new
  end

  def create!(content:)
    all_tasks << Task.create(content: content)
    print
  end

  def destroy!(*indexes)
    indexes = Array(indexes)

    indexes.sort.reverse_each do |index|
      next unless valid_index?(index)

      all_tasks[index - 1].delete
    end

    print
  end

  def complete!(*indexes)
    indexes = Array(indexes)

    indexes.each do |index|
      next unless valid_index?(index)

      unless (task = all_tasks[index - 1]).completed?
        task.mark_complete!
      end
    end

    print
  end

  def incomplete!(*indexes)
    indexes = Array(indexes)

    indexes.each do |index|
      next unless valid_index?(index)

      if (task = all_tasks[index - 1]).completed?
        task.mark_incomplete!
      end
    end

    print
  end

  def print(show_details: false)
    entries =
      all_tasks.map.with_index do |entry, index|
        line = "#{index + 1}."
        line = "#{line} #{entry}"
        line = "#{line}\n" if show_details
        line = "#{line}  - Created: #{entry.date_created}" if show_details
        line = "#{line}\n  - Completed: #{entry.date_completed}" if show_details && entry.date_completed
        line
      end

    puts(entries)
  end
  alias show print
  alias list print
  alias ls print
  alias tasks print
  alias to_s print

  def [](index)
    return unless valid_index?(index)

    all_tasks[index - 1]
  end

  private

  def all_tasks
    Task.all
  end

  def valid_index?(index)
    (0..all_tasks.count).cover?(index - 1)
  end
end
