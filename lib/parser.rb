# frozen_string_literal: true

require "optparse"

module RubyDo
  class Parser
    def self.parse!
      new.parse!
    end

    def initialize
      @options = {}
      @task_manager = TaskManager.open!
    end

    def parse!
      input.parse!
      dispatch_action!
    end

    private

    attr_accessor :options
    attr_reader :task_manager

    def dispatch_action!
      case action
      when :print      then show_tasks
      when :done       then mark_task_done!
      when :not_done   then mark_task_not_done!
      when :add        then add_task!
      when :remove     then remove_task!
      when :remove_all then remove_all_tasks!
      end
    end

    def action
      options[:action] || :print
    end

    def show_tasks
      task_manager.print(show_details: options[:show_details])
    end

    def mark_task_done!
      task_manager.done!(options[:task_indexes])
    end

    def mark_task_not_done!
      task_manager.not_done!(options[:task_indexes])
    end

    def add_task!
      task_manager.add!(content: options[:task_content])
    end

    def remove_task!
      task_manager.remove!(options[:task_indexes])
    end

    def remove_all_tasks!
      task_manager.remove_all!
    end

    def input
      OptionParser.new do |opts|
        opts.banner = "usage: ruby_do [options]"

        setup_show_tasks_options(opts)
        setup_task_done_options(opts)
        setup_task_not_done_options(opts)
        setup_new_task_options(opts)
        setup_remove_task_options(opts)
      end
    end

    def setup_show_tasks_options(opts)
      opts.on("--print", "--show", "--list", "--tasks", "Show tasks") do
        options[:action] = :print
      end

      opts.on("--details", "Show extra details for tasks") do
        options[:show_details] = true
      end
    end

    def setup_task_done_options(opts)
      opts.on("--done=TASK_INDEX(ES)", "Complete task(s) by index (comma-separated)") do |task_indexes|
        options[:action] = :done
        options[:task_indexes] = extract_integer_list(task_indexes)
      end
    end

    def setup_task_not_done_options(opts)
      opts.on("--not-done=TASK_INDEX(ES)", "Mark task(s) as not finished by index (comma-separated)") do |task_indexes|
        options[:action] = :not_done
        options[:task_indexes] = extract_integer_list(task_indexes)
      end
    end

    def setup_new_task_options(opts)
      opts.on("--add=TASK_CONTENT", "Add a new task") do |task_content|
        options[:action] = :add
        options[:task_content] = task_content
      end
    end

    def setup_remove_task_options(opts)
      opts.on("--remove=TASK_INDEX(ES)", "Remove task(s) by index (comma-separated)") do |task_indexes|
        options[:action] = :remove
        options[:task_indexes] = extract_integer_list(task_indexes)
      end

      opts.on("--remove-all", "Remove all tasks") do
        options[:action] = :remove_all
      end
    end

    def extract_integer_list(indexes)
      indexes.split(",").map { |i| Integer(i.strip) }
    end
  end
end
