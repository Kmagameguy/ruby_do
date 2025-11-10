# frozen_string_literal: true

require "bundler"
Bundler.require(:test)

require "fileutils"
require "json"
require "logger"
require "minitest/autorun"
require "minitest/spec"
require "mocha/minitest"

require_relative "../app"

Bundler.setup(:default, :test)

class ::Minitest::Test
  extend ::Minitest::Spec::DSL

  class << self
    alias context describe
  end
end
