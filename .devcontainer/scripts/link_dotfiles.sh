#!/usr/bin/env bash
set -euo pipefail


log() { echo "[stow] $*"; }


DOTS="$HOME/.dotfiles"
[[ -d "$DOTS" ]] || { echo "~/.dotfiles not found" >&2; exit 1; }


# Common modules to stow if present in the repo
MODULES=(git zsh tmux nvim kube)


for m in "${MODULES[@]}"; do
if [[ -d "$DOTS/$m" ]]; then
log "stow $m"
stow -d "$DOTS" -t "$HOME" "$m"
fi
done


# Quality-of-life defaults if missing
mkdir -p "$HOME/.kube"
