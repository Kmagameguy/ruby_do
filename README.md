# Ruby To-Dos

A simple command-line to-do list.

# Pre-requisites
1. Ruby installed and accessible through path
1. Bundler Gem
1. Sqlite

# Installation
1. Run `bin/setup`
1. Run `bundle exec rake db:migrate`
1. (Optional) Run `bundle exec rake db:seed` to populate the DB with some starter data

# Usage
1. Run `bin/console`
1. Work with the to-do list through the `RUBY_DO` constant:
    - List tasks: `RUBY_DO.show`, `RUBY_DO.list`, `RUBY_DO.ls`, `RUBY_DO.print` `RUBY_DO.tasks`, `RUBY_DO.to_s`
    - Mark task complete: `RUBY_DO.done!(indexes)`
    - Mark task incomplete: `RUBY_DO.not_done!(indexes)`
    - See when tasks were created/completed: `RUBY_DO.print(show_details: true)`
    - Create a task: `RUBY_DO.add!(content: "Your Task")`
    - Delete a task: `RUBY_DO.remove!(indexes)`
