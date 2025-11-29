# frozen_string_literal: true

require "test_helper"

class TaskManagerTest < Minitest::Test
  let(:subject) { ::TaskManager }

  before { DB[:tasks].delete }

  describe ".open!" do
    it "creates a new TaskManager instance" do
      assert_kind_of(TaskManager, subject.open!)
    end
  end

  describe "#add!" do
    before { @task_manager = subject.open! }

    it "adds a new task" do
      before_count = Task.count
      @task_manager.add!(content: "test task")
      after_count = Task.count

      assert_equal before_count + 1, after_count
    end
  end

  describe "#remove!" do
    before do
      @task_manager = subject.open!
      ["test task 1", "test task 2"].each do |task|
        Task.add!(content: task)
      end
    end

    it "removes the selected task" do
      before_count = Task.count
      @task_manager.remove!(2)
      after_count = Task.count

      assert_equal before_count - 1, after_count
      assert_equal after_count, @task_manager.__send__(:all_tasks).count
    end

    it "can remove many tasks at once" do
      before_count = Task.count
      @task_manager.remove!(1, 2)
      after_count = Task.count

      assert_equal before_count - 2, after_count
      assert_equal after_count, @task_manager.__send__(:all_tasks).count
    end

    it "skips invalid indexes" do
      before_count = Task.count
      @task_manager.remove!(9_999_999)
      after_count = Task.count

      assert_equal before_count, after_count
      assert_equal before_count, @task_manager.__send__(:all_tasks).count
    end
  end

  describe "#done!" do
    before do
      @task_manager = subject.open!
      ["test task 1", "test task 2"].each do |task|
        Task.create(content: task)
      end
    end

    it "marks the selected task complete" do
      @task_manager.done!(1)

      assert_predicate(@task_manager.__send__(:all_tasks).first, :done?)
    end

    it "can mark multiple tasks complete at once" do
      @task_manager.done!(1, 2)

      assert_predicate(@task_manager.__send__(:all_tasks).first, :done?)
      assert_predicate(@task_manager.__send__(:all_tasks)[1], :done?)
    end

    it "skips invalid indexes" do
      @task_manager.done!(9_999_999)

      @task_manager.__send__(:all_tasks).each do |task|
        refute_predicate(task, :done?)
      end
    end
  end

  describe "#not_done!" do
    before do
      @task_manager = subject.open!
      ["test task 1", "test task 2"].each do |task|
        Task.create(content: task).done!
      end
    end

    it "can mark a completed task incomplete again" do
      task = @task_manager.__send__(:all_tasks).first

      assert_predicate(task, :done?)

      @task_manager.not_done!(1)

      refute_predicate(task.reload, :done?)
    end

    it "can mark many completed tasks incomplete again" do
      tasks = @task_manager.__send__(:all_tasks)

      tasks.each do |task|
        assert_predicate(task.reload, :done?)
      end

      @task_manager.not_done!(1, 2)

      tasks.each do |task|
        refute_predicate(task.reload, :done?)
      end
    end

    it "skips invalid indexes" do
      @task_manager.not_done!(9_999_999)

      @task_manager.__send__(:all_tasks).each do |task|
        assert_predicate(task.reload, :done?)
      end
    end
  end

  describe "#[]" do
    before do
      @task_manager = subject.open!
      ["test task 1", "test task 2"].each do |task|
        Task.create(content: task)
      end
    end

    it "can access tasks like a 1-indexed array" do
      assert_equal Task.all[1], @task_manager[2]
    end

    it "returns nothing if an element isn't at the specified position" do
      assert_nil @task_manager[9_999_999]
    end
  end
end
