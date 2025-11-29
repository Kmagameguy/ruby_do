# frozen_string_literal: true

require "bundler"
Bundler.require(:default)
require "dotenv/load"
require "fileutils"
require "json"
require "logger"
require "sequel"
require "time"

require_relative "lib/database"
require_relative "lib/models"
require_relative "lib/services"
