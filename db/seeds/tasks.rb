# frozen_string_literal: true

require_relative "../../app"

DB[:tasks].delete
[
  "Trim the tree",
  "Take out the trash",
  "Pet the dog"
].each do |task|
  Task.create(content: task)
end
