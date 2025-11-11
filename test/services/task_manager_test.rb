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

  describe "#create!" do
    before { @task_manager = subject.open! }

    it "creates a new task" do
      before_count = Task.count
      @task_manager.create!(content: "test task")
      after_count = Task.count

      assert_equal before_count + 1, after_count
    end
  end

  describe "#destroy!" do
    before do
      @task_manager = subject.open!
      ["test task 1", "test task 2"].each do |task|
        Task.create(content: task)
      end
    end

    it "destroys the selected task" do
      before_count = Task.count
      @task_manager.destroy!(2)
      after_count = Task.count

      assert_equal before_count - 1, after_count
      assert_equal after_count, @task_manager.__send__(:all_tasks).count
    end

    it "can destroy many tasks at once" do
      before_count = Task.count
      @task_manager.destroy!(1, 2)
      after_count = Task.count

      assert_equal before_count - 2, after_count
      assert_equal after_count, @task_manager.__send__(:all_tasks).count
    end

    it "skips invalid indexes" do
      before_count = Task.count
      @task_manager.destroy!(9_999_999)
      after_count = Task.count

      assert_equal before_count, after_count
      assert_equal before_count, @task_manager.__send__(:all_tasks).count
    end
  end

  describe "#complete!" do
    before do
      @task_manager = subject.open!
      ["test task 1", "test task 2"].each do |task|
        Task.create(content: task)
      end
    end

    it "marks the selected task complete" do
      @task_manager.complete!(1)

      assert_predicate(@task_manager.__send__(:all_tasks).first, :completed?)
    end

    it "can mark multiple tasks complete at once" do
      @task_manager.complete!(1, 2)

      assert_predicate(@task_manager.__send__(:all_tasks).first, :completed?)
      assert_predicate(@task_manager.__send__(:all_tasks)[1], :completed?)
    end

    it "skips invalid indexes" do
      @task_manager.complete!(9_999_999)

      @task_manager.__send__(:all_tasks).each do |task|
        refute_predicate(task, :completed?)
      end
    end
  end

  describe "#incomplete!" do
    before do
      @task_manager = subject.open!
      ["test task 1", "test task 2"].each do |task|
        Task.create(content: task).mark_complete!
      end
    end

    it "can mark a completed task incomplete again" do
      task = @task_manager.__send__(:all_tasks).first

      assert_predicate(task, :completed?)

      @task_manager.incomplete!(1)

      refute_predicate(task.reload, :completed?)
    end

    it "can mark many completed tasks incomplete again" do
      tasks = @task_manager.__send__(:all_tasks)

      tasks.each do |task|
        assert_predicate(task.reload, :completed?)
      end

      @task_manager.incomplete!(1, 2)

      tasks.each do |task|
        refute_predicate(task.reload, :completed?)
      end
    end

    it "skips invalid indexes" do
      @task_manager.incomplete!(9_999_999)

      @task_manager.__send__(:all_tasks).each do |task|
        assert_predicate(task.reload, :completed?)
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
