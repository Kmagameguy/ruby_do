require "test_helper"

module ToDo
  class TaskTest < ::Minitest::Test
    let(:content) { "This is a test" }
    let(:humanized_date_pattern) { "%b %e, %Y @ %l:%M%P" }
    let(:subject) { ::ToDo::Task }

    before { @task = subject.new(content: content) }
    
    describe ".initialize" do
      it "creates a new task with valid arguments" do
        assert @task.is_a?(::ToDo::Task)
      end

      it "has a created_at date" do
        refute_nil @task.instance_variable_get("@created_at")
      end

      it "does not have a completed_at date" do
        assert_nil @task.instance_variable_get("@completed_at")
      end
    end

    describe "#created_at" do
      let(:created_at) { Time.now }

      before { @task.instance_variable_set(:@created_at, created_at) }

      it "humanizes the date by default" do
        assert_equal created_at.strftime(humanized_date_pattern), @task.created_at    
      end

      it "can return the raw date" do
        assert_equal created_at, @task.created_at(humanize: false)
      end
    end

    describe "#completed_at" do
      let(:hour_in_seconds) { 3600 }
      let(:completed_at) { Time.now + hour_in_seconds }

      before { @task.instance_variable_set(:@completed_at, completed_at) }

      it "humanizes the date by default" do
        assert_equal completed_at.strftime(humanized_date_pattern), @task.completed_at
      end

      it "can return the raw date" do
        assert_equal completed_at, @task.completed_at(humanize: false)
      end
    end

    describe "#mark_complete!" do
      it "sets a completed_at timestamp" do
        @task.mark_complete!

        refute_nil @task.completed_at
      end
    end

    describe "#mark_incomplete!" do
      it "removes the completed_at timestamp" do
        @task.mark_complete!

        refute_nil @task.completed_at

        @task.mark_incomplete!

        assert_nil @task.completed_at
      end
    end

    describe "#completed?" do
      it "returns true if a completed_at timestamp is present" do
        @task.mark_complete!
        
        assert_predicate(@task, :completed?)
      end

      it "returns false if a completed_at timestamp is not present" do
        refute_predicate(@task, :completed?)
      end
    end

    describe "#to_s" do
      context "when the task is incomplete" do
        it "formats the task with an empty checkbox" do
          assert_equal "[ ] #{content}", @task.to_s
        end
      end

      context "when the task is complete" do
        before { @task.mark_complete! }

        it "formats the task with a filled-in checkbox" do
          assert_equal "[x] #{content}", @task.to_s
        end
      end
    end
  end
end
