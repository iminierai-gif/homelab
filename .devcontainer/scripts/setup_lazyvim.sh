#!/usr/bin/env bash
set -euo pipefail


NVIM_DIR="$HOME/.config/nvim"


# If dotfiles already provided nvim config, do nothing
if [[ -d "$NVIM_DIR" && -n "$(ls -A "$NVIM_DIR" 2>/dev/null)" ]]; then
echo "[lazyvim] nvim config exists; skipping starter clone."
exit 0
fi


echo "[lazyvim] Installing LazyVim starter..."
# LazyVim Starter: https://github.com/LazyVim/starter
# Creates a clean, minimal LazyVim setup
mkdir -p "$HOME/.config"
git clone https://github.com/LazyVim/starter "$NVIM_DIR"
rm -rf "$NVIM_DIR/.git"
