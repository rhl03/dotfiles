#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
stow -R -t "$HOME" bash
for pkg in hypr alacritty nvim quickshell zathura; do
  mkdir -p "$HOME/.config/$pkg"
  stow -R -t "$HOME/.config/$pkg" "$pkg"
done
