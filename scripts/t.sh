#!/usr/bin/env bash

# Check if at least one argument is provided
if [ $# -eq 0 ]; then
  echo "Please provide at least one argument for tldr."
  exit 1
fi

# Command to run
COMMAND="tldr \"$@\" | less"

# Create the popup with the tldr command and the arguments
tmux display-popup -w 80% -h 80% -E "$COMMAND"

