# frozen_string_literal: true

class TaskManager
  def self.open!
    new
  end

  def add!(content:)
    all_tasks << Task.add!(content: content)
    print
  end

  def remove!(*indexes)
    make_array(indexes).sort.reverse_each do |index|
      next unless valid_index?(index)

      all_tasks[index - 1].remove!
    end

    print
  end

  def done!(*indexes)
    make_array(indexes).each do |index|
      next unless valid_index?(index)

      unless (task = all_tasks[index - 1]).done?
        task.done!
      end
    end

    print
  end

  def not_done!(*indexes)
    make_array(indexes).each do |index|
      next unless valid_index?(index)

      if (task = all_tasks[index - 1]).done?
        task.not_done!
      end
    end

    print
  end

  def print(show_details: false)
    puts(formatted_tasks(show_details: show_details))
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

  def formatted_tasks(show_details: false)
    tasks =
      all_tasks.map.with_index do |entry, index|
        line = "#{index + 1}."
        line = "#{line} #{entry}"
        line = "#{line}#{format_task_details(entry)}" if entry && show_details

        line
      end

    tasks.empty? ? "No tasks found!" : tasks.join("\n")
  end

  def format_task_details(task)
    detail = "\n"
    detail = "#{detail}  - Created: #{task.date_created}"
    detail = "#{detail}\n  - Completed: #{task.date_completed}" if task.done?
    detail
  end

  def all_tasks
    Task.all
  end

  def valid_index?(index)
    (0..all_tasks.count).cover?(index - 1)
  end

  def make_array(opts)
    opts.flat_map { |i| i.is_a?(Array) ? i : [i] }
  end
end
