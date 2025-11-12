# frozen_string_literal: true

Bundler.require(:test)
Bundler.setup(:default, :test)

require "minitest/autorun"
require "minitest/spec"
require "mocha/minitest"
require "rake"

Rake.application.init
Rake.application.load_rakefile

require_relative "../lib/database"

Rake::Task["db:migrate"].invoke

require_relative "../app"

class ::Minitest::Test
  extend ::Minitest::Spec::DSL

  class << self
    alias context describe
  end
end
