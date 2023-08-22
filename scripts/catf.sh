#!/usr/bin/env bash

# Function to check if the argument is a valid directory path
is_directory() {
  [ -d "$1" ]
}

# If no argument is provided, use the current directory
path="."
query=""

# If an argument is provided, check if it's a valid directory
if [ -n "$1" ]; then
  if is_directory "$1"; then
    path="$1"
  else
    query="$1"
  fi
fi

# Search for files using fzf and the provided path or query
file=$(find "$path" -type f | fzf --query "$query")

# If a file is selected, open it in Vim
if [ -n "$file" ]; then
  cat "$file"
else
  echo "No file selected"
fi
