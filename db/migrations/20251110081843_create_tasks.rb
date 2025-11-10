# frozen_string_literal: true

Sequel.migration do
  up do
    run "PRAGMA journal_mode = WAL"
    run "PRAGMA foreign_keys = ON"
    run "PRAGMA synchronous = NORMAL"
    run "PRAGMA busy_timeout = 5000"
    run "PRAGMA auto_index = ON"
    run "PRAGMA temp_store = MEMORY"
    run "PRAGMA cache_size = -10000"
    run "PRAGMA mmap_size = 268435456"

    create_table :tasks do
      primary_key :id
      String :content, null: false
      DateTime :completed_at, default: nil
      DateTime :created_at, null: false, default: Sequel::CURRENT_TIMESTAMP
      DateTime :updated_at, null: false, default: Sequel::CURRENT_TIMESTAMP
    end
  end

  down do
    drop_table :tasks
    run "PRAGMA journal_mode = DELETE"
    run "PRAGMA foreign_keys = OFF"
    run "PRAGMA synchronous = FULL"
    run "PRAGMA busy_timeout = 0"
    run "PRAGMA autoamtic_index = ON"
    run "PRAGMA temp_store = DEFAULT"
    run "PRAGMA cache_size = -2000"
    run "PRAGMA mmap_size = 0"
  end
end
