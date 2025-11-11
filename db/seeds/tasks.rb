# frozen_string_literal: true

require_relative "../../lib/database"
require_relative "../../lib/models/task"

DB[:tasks].delete
[
  "Trim the tree",
  "Take out the trash",
  "Pet the dog"
].each do |task|
  Task.create(content: task)
end
