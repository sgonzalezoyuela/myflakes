#!/usr/bin/env bash

# Check if file exists
if [ ! -f "$1" ]; then
  echo "File $1 does not exist."
  exit 1
fi

# Detect if running under Wayland or X11
if [ -n "$WAYLAND_DISPLAY" ]; then
  # Using wl-copy for Wayland
  if command -v wl-copy >/dev/null 2>&1; then
    wl-copy < "$1"
  else
    echo "Error: wl-copy not found. Please install wl-clipboard package."
    exit 1
  fi
else
  # Using xclip for X11
  if command -v xclip >/dev/null 2>&1; then
    xclip -selection clipboard < "$1"
  else
    echo "Error: xclip not found. Please install xclip package."
    exit 1
  fi
fi

echo "Contents of $1 copied to clipboard."
