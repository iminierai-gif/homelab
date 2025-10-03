#!/usr/bin/env bash
set -euo pipefail

log() { echo "[bootstrap] $*"; }

# Ensure scripts are runnable & unix-formatted (works even on Windows checkouts)
for f in .devcontainer/scripts/*.sh; do
  if [ -f "$f" ]; then
    sed -i 's/
$//' "$f" 2>/dev/null || true
    chmod +x "$f" 2>/dev/null || true
  fi
done

REPO="${DOTFILES_REPO:-}"
BRANCH="${DOTFILES_BRANCH:-main}"

if [[ -z "${REPO}" ]]; then
  echo "DOTFILES_REPO is not set. Set it in devcontainer.json -> containerEnv." >&2
  exit 1
fi

# Ensure basic binaries exist
for bin in git stow zsh tmux nvim kubectl; do
  command -v "$bin" >/dev/null || {
    echo "Missing $bin" >&2
    exit 1
  }
done

".devcontainer/scripts/clone_dotfiles.sh" "$REPO" "$BRANCH"
".devcontainer/scripts/link_dotfiles.sh"
".devcontainer/scripts/setup_lazyvim.sh"
".devcontainer/scripts/setup_tmux.sh"

log "Done. Open 'nvim' once to finish LazyVim plugin install."
