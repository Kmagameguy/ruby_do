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
    all << Task.new(content: content)
    print
  end

  def destroy!(index)
    return unless (0..all.size).cover?(index - 1)

    all.delete_at(index - 1)
    print
  end

  def all
    @tasks
  end

  def print
    entries =
      all.map.with_index do |entry, index|
        "#{index + 1}. #{entry}"
      end

    puts(entries)
  end
  alias show print
  alias list print
  alias ls print

  private

  def load_tasks!
    @tasks =
      ["Trim the tree", "Take out the trash", "Pet the dog"].map do |str|
        Task.new(content: str)
      end
  end
end
