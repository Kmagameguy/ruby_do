# frozen_string_literal: true

class TaskManager
  def self.open!
    new
  end

  def initialize
    load_tasks!
    print
  end

  def all_tasks
    @tasks
  end

  def create!(content:)
    all_tasks << Task.new(content: content)
    print
  end

  def destroy!(index)
    return unless (0..all.size).cover?(index - 1)

    all.delete_at(index - 1)
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
end
