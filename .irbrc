# frozen_string_literal: true

require "dotenv/load"
require "bundler"
Bundler.require
require_relative "app"

TASK_MANAGER = TaskManager.open!
