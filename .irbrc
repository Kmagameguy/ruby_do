# frozen_string_literal: true

require "bundler"
Bundler.require
require_relative "app"

TASK_MANAGER = TaskManager.open!
