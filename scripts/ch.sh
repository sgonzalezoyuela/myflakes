#!/usr/bin/env bash

# Check if a command name is provided
if [ $# -eq 0 ]; then
  echo "Please provide a command name for the cheat sheet."
  exit 1
fi

# Construct the URL for the cheat sheet
URL="https://cheat.sh/$1"

# Command to run
COMMAND="curl -s \"$URL\" | less"

# Create the popup with the curl command to fetch the cheat sheet and display it with less
tmux display-popup -w 80% -h 80% -E "$COMMAND"

