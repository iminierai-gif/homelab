#!/usr/bin/env bash
set -euo pipefail


# Install TPM (tmux plugin manager) if not present
TPM_DIR="$HOME/.tmux/plugins/tpm"
if [[ ! -d "$TPM_DIR" ]]; then
echo "[tmux] installing TPM..."
git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
fi


# Optionally pre-install plugins non-interactively
if command -v tmux >/dev/null; then
tmux start-server
tmux new-session -d || true
"$TPM_DIR/bin/install_plugins" || true
tmux kill-server || true
fi
