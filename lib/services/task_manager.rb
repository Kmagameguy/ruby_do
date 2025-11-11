# frozen_string_literal: true

class TaskManager
  def self.open!
    new
  end

  def initialize
    load_tasks!
    print
  end

  def create!(content:)
    all_tasks << Task.new(content: content)
    print
  end

  def destroy!(index)
    return unless valid_index?

    all.delete_at(index - 1)
    print
  end

  def complete!(index)
    raise(ArgumentError, "Invalid index: #{index}") unless valid_index?(index)

    unless (task = all_tasks[index - 1]).completed?
      task.mark_complete!
    end

    print
  end

  def incomplete!(index)
    raise(ArgumentError, "Invalid index: #{index}") unless valid_index?(index)

    if (task = all_tasks[index - 1]).completed?
      task.mark_incomplete!
    end

    print
  end

  def print
    entries =
      all_tasks.map.with_index do |entry, index|
        "#{index + 1}. #{entry}"
      end

    puts(entries)
  end
  alias show print
  alias list print
  alias ls print
  alias tasks print
  alias to_s print

  def [](index)
    all_tasks[index]
  end

  private

  def load_tasks!
    @tasks = Task.all
  end

  def all_tasks
    @tasks
  end

  def valid_index?(index)
    (0..all_tasks.count).cover?(index - 1)
  end
end
