#!/usr/bin/env bash

if [ ! -f "$1" ]; then
  echo "File $1 does not exist."
  exit 1
fi

cat "$1" | xclip -selection clipboard
