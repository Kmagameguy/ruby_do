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
1. (Optional) Run `bin/install` to symlink `bin/ruby_do` to `/usr/local/bin/`.  This will let you call `ruby_do` from your command line, anywhere

# Usage
## From the ruby_do Script
- List tasks: `ruby_do --print`, `ruby_do --show`, `ruby_do --list`, `ruby_do --tasks`
- See when tasks were created/completed: `ruby_do --print --details`
- Mark tasks done by their index in the list: `ruby_do --done 1,2`
- Mark tasks not done by their index in the list: `ruby_do --not-done 1,2`
- Add a task: `ruby_do --add TASK_CONTENT`
- Remove a task: `ruby_do --remove TASK_CONTENT`

## From the Ruby Command Line
1. Run `bin/console`
1. Work with the to-do list through the `RUBY_DO` constant:
    - List tasks: `RUBY_DO.show`, `RUBY_DO.list`, `RUBY_DO.ls`, `RUBY_DO.print` `RUBY_DO.tasks`, `RUBY_DO.to_s`
    - See when tasks were created/completed: `RUBY_DO.print(show_details: true)`
    - Mark tasks done by their index in the list: `RUBY_DO.done!(1,2)`
    - Mark tasks not done by their index in the list: `RUBY_DO.not_done!(1,2)`
    - Add a task: `RUBY_DO.add!(content: "Your Task")`
    - Remove a task: `RUBY_DO.remove!(2,3)`
