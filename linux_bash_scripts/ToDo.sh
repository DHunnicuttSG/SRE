#!/bin/bash

TODO_FILE="$HOME/todo.txt"

# Create file if it doesn’t exist
[ ! -f "$TODO_FILE" ] && touch "$TODO_FILE"

# --- Functions ----------------------------------

list_todos() {
    if [ ! -s "$TODO_FILE" ]; then
        echo "✅ No tasks yet. Add one with: ./todo.sh add 'Task name'"
    else
        echo "📝 Your To-Do List:"
        nl -w2 -s'. ' "$TODO_FILE"
    fi
}

add_todo() {
    if [ -z "$1" ]; then
        echo "⚠️  Usage: ./todo.sh add 'Task description'"
        exit 1
    fi
    echo "$1" >> "$TODO_FILE"
    echo "✅ Added: $1"
}

delete_todo() {
    if [ -z "$1" ]; then
        echo "⚠️  Usage: ./todo.sh del [task_number]"
        exit 1
    fi
    if ! [[ "$1" =~ ^[0-9]+$ ]]; then
        echo "⚠️  Task number must be numeric."
        exit 1
    fi
    if [ "$1" -le 0 ] || [ "$1" -gt "$(wc -l < "$TODO_FILE")" ]; then
        echo "❌ Invalid task number."
        exit 1
    fi
    sed -i "${1}d" "$TODO_FILE"
    echo "🗑️  Deleted task #$1"
}

# --- Main logic ---------------------------------

case "$1" in
    add)
        shift
        add_todo "$*"
        ;;
    list)
        list_todos
        ;;
    del|delete|remove)
        shift
        delete_todo "$1"
        ;;
    *)
        echo "Usage:"
        echo "  ./todo.sh add \"Task description\"   → Add a task"
        echo "  ./todo.sh list                      → Show all tasks"
        echo "  ./todo.sh del [task_number]         → Delete a task"
        ;;
esac
