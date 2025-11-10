# frozen_string_literal: true

require "fileutils"
require "logger"
require "sequel"

FileUtils.mkdir_p("db")
DB = Sequel.sqlite("db/development.db", foreign_keys: true, synchronous: :normal, temp_store: :memory, timeout: 5_000)
DB.loggers << Logger.new($stdout)
