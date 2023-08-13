#!/usr/bin/env bash

set -e

script_folder="./scripts"

for script_file in "$script_folder"/*.sh; do
  flake_name=$(basename "$script_file" .sh)
  echo "Building flake for $flake_name..."
  nix build ".#$flake_name"
  echo "Installing flake for $flake_name..."
  nix profile install --profile "/nix/var/nix/profiles/per-user/$USER/$flake_name" ".#$flake_name"
  #nix profile install ".#$flake_name"
done

echo "All flakes have been built successfully!"
