source "https://rubygems.org"

gem "dotenv"
# Temporarily add rdoc to silence annoying irb deprecation warning
gem "rdoc"
gem "sequel"
gem "sqlite3"

group :development, :test do
  gem "logger"
  gem "rubocop"
  gem "rubocop-minitest"
  gem "rubocop-performance"
  gem "rubocop-rake"
  gem "rubocop-sequel"
end

group :test do
  gem "minitest"
  gem "minitest-ci", require: false
  gem "minitest-focus"
  gem "minitest-hooks"
  gem "minitest-reporters"
  gem "mocha"
  gem "rake"
end
