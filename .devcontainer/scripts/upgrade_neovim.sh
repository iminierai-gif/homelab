#!/usr/bin/env bash
set -euo pipefail
VER="${1:-0.11.2}"
ARCH="$(uname -m)"
case "$ARCH" in
x86_64 | amd64)
  ARCH_TAG="x86_64"
  ALT_FILE="nvim-linux64.tar.gz"
  ;;
aarch64 | arm64)
  ARCH_TAG="arm64"
  ALT_FILE="nvim-linux-arm64.tar.gz"
  ;;
*)
  echo "Unsupported arch: $ARCH" >&2
  exit 1
  ;;
esac

TMP="$(mktemp -d)"
cd "$TMP"

URLS=(
  "https://github.com/neovim/neovim/releases/download/v${VER}/nvim-linux-${ARCH_TAG}.tar.gz"
  "https://github.com/neovim/neovim-releases/releases/download/v${VER}/${ALT_FILE}"
)

for url in "${URLS[@]}"; do
  echo "[nvim] trying $url"
  if curl -fsSL -o nvim.tar.gz "$url"; then
    break
  fi
done

if [[ ! -s nvim.tar.gz ]]; then
  echo "Failed to download Neovim v$VER for $ARCH" >&2
  exit 1
fi

# Extract and install to ~/.local
TOPDIR="$(tar tzf nvim.tar.gz | head -1 | cut -d/ -f1)"
tar xzf nvim.tar.gz
[[ -d "$TOPDIR" ]] || TOPDIR="nvim-linux-${ARCH_TAG}"
rm -rf "$HOME/.local/$TOPDIR"
mv "$TOPDIR" "$HOME/.local/"
mkdir -p "$HOME/.local/bin"
ln -sfn "$HOME/.local/$TOPDIR/bin/nvim" "$HOME/.local/bin/nvim"

# Show version
"$HOME/.local/bin/nvim" --version | head -n1
