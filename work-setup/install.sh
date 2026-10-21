#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

# bash lives directly in $HOME (.bashrc, .bash_profile)
stow -R -t "$HOME" bash

# Every other folder is a flat package that belongs in ~/.config/<name>
for dir in */; do
  pkg="${dir%/}"
  [[ "$pkg" == "bash" ]] && continue
  mkdir -p "$HOME/.config/$pkg"
  stow -R -t "$HOME/.config/$pkg" "$pkg"
done
