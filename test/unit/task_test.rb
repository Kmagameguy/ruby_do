# frozen_string_literal: true

require "test_helper"

class TaskTest < Minitest::Test
  let(:content) { "This is a test" }
  let(:humanized_date_pattern) { "%b %e, %Y @ %l:%M%P" }
  let(:subject) { ::Task }

  before { @task = subject.add(content: content) }

  describe ".initialize" do
    it "creates a new task with valid arguments" do
      assert_kind_of(::Task, @task)
    end

    it "has a date_created date" do
      refute_nil @task.date_created
    end

    it "has an updated_at date" do
      refute_nil @task.updated_at
    end

    it "does not have a date_completed date" do
      assert_nil @task.date_completed
    end
  end

  describe "#date_created" do
    let(:date_created) { Time.now }

    before { @task.update(created_at: date_created) }

    it "humanizes the date by default" do
      assert_equal date_created.strftime(humanized_date_pattern), @task.date_created
    end

    it "can return the raw date" do
      assert_equal date_created, @task.date_created(humanize: false)
    end
  end

  describe "#date_completed" do
    let(:hour_in_seconds) { 3600 }
    let(:date_completed) { Time.now + hour_in_seconds }

    before { @task.update(completed_at: date_completed) }

    it "humanizes the date by default" do
      assert_equal date_completed.strftime(humanized_date_pattern), @task.date_completed
    end

    it "can return the raw date" do
      assert_equal date_completed, @task.date_completed(humanize: false)
    end
  end

  describe "#done" do
    it "sets a date_completed timestamp" do
      @task.done

      refute_nil @task.date_completed
    end
  end

  describe "#not_done" do
    it "removes the date_completed timestamp" do
      @task.done

      refute_nil @task.date_completed

      @task.not_done

      assert_nil @task.date_completed
    end
  end

  describe "#done?" do
    it "returns true if a date_completed timestamp is present" do
      @task.done

      assert_predicate(@task, :done?)
    end

    it "returns false if a date_completed timestamp is not present" do
      refute_predicate(@task, :done?)
    end
  end

  describe "#to_s" do
    context "when the task is incomplete" do
      it "formats the task with an empty checkbox" do
        assert_equal "[ ] #{content}", @task.to_s
      end
    end

    context "when the task is complete" do
      before { @task.done }

      it "formats the task with a filled-in checkbox" do
        assert_equal "[x] #{content}", @task.to_s
      end
    end
  end
end
