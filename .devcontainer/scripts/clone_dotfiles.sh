#!/usr/bin/env bash
set -euo pipefail


REPO_URL=${1:?"repo URL required"}
BRANCH=${2:-main}
TARGET_DIR="$HOME/.dotfiles"


log() { echo "[dotfiles] $*"; }


if [[ -d "$TARGET_DIR/.git" ]]; then
log "Repo exists; pulling latest..."
git -C "$TARGET_DIR" fetch --all --prune
git -C "$TARGET_DIR" checkout "$BRANCH"
git -C "$TARGET_DIR" pull --ff-only
else
log "Cloning $REPO_URL (branch: $BRANCH) -> $TARGET_DIR"
git clone --branch "$BRANCH" --depth 1 "$REPO_URL" "$TARGET_DIR"
fi
