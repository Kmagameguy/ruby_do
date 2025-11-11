# Ruby To-Dos

A simple command-line to-do list.

# Pre-requisites
1. Ruby installed and accessible through path
1. Bundler Gem
1. Sqlite

# Installation
1. Run `bin/setup`
1. (Optional) Run `bundle exec rake db:seed` to populate the DB with some starter data

# Usage
1. Run `bin/console`
1. Work with the to-do list through the `TASK_MANAGER` constant:
    - List tasks: `TASK_MANAGER.show`, `TASK_MANAGER.list`, `TASK_MANAGER.ls`, `TASK_MANAGER.print` `TASK_MANAGER.tasks`, `TASK_MANAGER.to_s`
    - Mark task complete: `TASK_MANAGER.complete!(indexes)`
    - Mark task incomplete: `TASK_MANAGER.incomplete!(indexes)`
    - See when tasks were created/completed: `TASK_MANAGER.print(show_details: true)`
    - Create a task: `TASK_MANAGER.create!(content: "Your Task")`
    - Delete a task: `TASK_MANAGER.destroy!(indexes)`
