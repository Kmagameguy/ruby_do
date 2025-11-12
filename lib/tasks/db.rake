# frozen_string_literal: true

require_relative "../database"

namespace :db do
  desc "Run database migrations"
  task :migrate do
    puts "Running database migrations..."
    Sequel.extension(:migration)
    Sequel::Migrator.run(DB, "db/migrations")
    puts "Migrations complete!"
  end

  desc "Seed the database"
  task :seed do
    puts "Seeding the database tables..."
    Dir[File.join(__dir__, "..", "..", "db", "seeds", "*.rb")].each { |file| load file }
    puts "Seed complete!"
  end

  desc "Create a new migration"
  task :generate_migration, [:name] do |_t, args|
    name = args[:name] || raise("Migration name required: rake db:generate_migration[migration_name]")
    timestamp = Time.now.strftime("%Y%m%d%H%M%S")
    filename = "#{timestamp}_#{name}.rb"
    migration_home = "db/migrations"
    filepath = "#{migration_home}/#{filename}"

    migration_content = <<~RUBY
      # frozen_string_literal: true

      Sequel.migration do
        up do
          # Add migration instructions here
        end

        down do
          # Add rollback instructions here
        end
      end
    RUBY

    FileUtils.mkdir_p(migration_home)
    File.write(filepath, migration_content)
    puts "Created migration: #{filepath}"
  end

  desc "Rebuild database (Drop and recreate)"
  task :rebuild do
    puts "Rebuilding database..."
    Dir.glob("db/*.db*").each { |file| File.delete(file) }
    Object.__send__(:remove_const, :DB) if defined?(DB)
    load File.expand_path("../database.rb", __dir__)
    Rake::Task["db:migrate"].invoke
    puts "Database rebuilt!"
  end
end
