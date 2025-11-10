# frozen_string_literal: true

Dir[File.join(__dir__, "models", "*.rb")].each { |file| require file }
