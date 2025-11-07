require "fileutils"
require "json"
require "time"
require_relative "./to_do/task"
require_relative "./to_do/menu"

module ToDo
  autoload :Task, "to_do/task"
  autoload :Menu, "to_do/menu"
end

