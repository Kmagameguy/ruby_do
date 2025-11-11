# frozen_string_literal: true

require "bundler"
Bundler.require(:test)

require "dotenv/load"
require "fileutils"
require "json"
require "logger"
require "minitest/autorun"
require "minitest/spec"
require "mocha/minitest"

require_relative "../lib/database"

Bundler.setup(:default, :test)

Sequel.extension(:migration)
Sequel::Migrator.run(DB, "db/migrations")

require_relative "../app"

class ::Minitest::Test
  extend ::Minitest::Spec::DSL

  class << self
    alias context describe
  end
end
