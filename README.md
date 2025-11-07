# Ruby To-Dos

A simple command-line to-do list.

# Pre-requisites
1. Ruby installed and accessible through path
1. Bundler Gem

# Installation
1. Run `bin/setup`

# Usage
1. Run `bin/console`
1. Work with the to-do list through the `TODOS` constant:
    - List tasks: `TODOS.show`, `TODOS.list`, `TODOS.ls`
    - Mark task complete: `TODOS.all.first.mark_complete!`
    - Mark task incomplete: `TODOS.all.first.mark_incomplete!`
    - See when task was created: `TODOS.all.first.created_at`
    - See when task was completed: `TODOS.all.first.completed_at`
    - Create a task: `TODOS.create!(content: "Your Task")`
    - Delete a task: `TODOS.destroy!(task_index)`

