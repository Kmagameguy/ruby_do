require "bundler"
Bundler.require
require_relative "./lib/to_do"

TODOS= ::ToDo::Menu.open!

