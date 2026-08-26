#!/usr/bin/env bash
#
# Installs every external dependency required by this Neovim config:
#   - LSP servers: lua_ls, pyright, ts_ls (typescript-language-server), gopls
#   - CLI tools used by plugins: ripgrep (telescope), fd, lazygit, glow
#   - Build tools needed by nvim-treesitter to compile parsers
#
# Works on macOS (Homebrew) and Fedora Linux (dnf). Safe to re-run any time
# (every step is idempotent / skips already-installed tools).
#
# Usage: bash ~/.config/nvim/scripts/install-deps.sh

set -euo pipefail

have() { command -v "$1" >/dev/null 2>&1; }
log() { printf '\n==> %s\n' "$1"; }

OS="$(uname -s)"

# ---------------------------------------------------------------------------
# 1. Base packages via the platform's package manager
# ---------------------------------------------------------------------------

install_base_packages_macos() {
  if ! have brew; then
    echo "Homebrew not found. Install it from https://brew.sh first." >&2
    exit 1
  fi
  log "Installing base packages via Homebrew"
  brew install ripgrep fd lazygit glow go lua-language-server node
}

install_base_packages_fedora() {
  log "Installing base packages via dnf"
  sudo dnf install -y ripgrep fd-find lazygit glow golang nodejs npm \
    gcc gcc-c++ make git curl unzip
}

case "$OS" in
  Darwin) install_base_packages_macos ;;
  Linux)
    if have dnf; then
      install_base_packages_fedora
    else
      echo "This script only automates Fedora (dnf) on Linux. Install ripgrep, fd, lazygit, glow, go, node/npm, and a C compiler manually, then re-run this script to get the LSP servers." >&2
    fi
    ;;
  *)
    echo "Unsupported OS: $OS. Install dependencies manually." >&2
    ;;
esac

# ---------------------------------------------------------------------------
# 2. lua-language-server on Fedora (no dnf package available upstream)
# ---------------------------------------------------------------------------

install_lua_ls_from_release() {
  have lua-language-server && { log "lua-language-server already installed"; return; }

  log "Installing lua-language-server from GitHub release (no Fedora package available)"
  local arch tag url install_dir
  case "$(uname -m)" in
    x86_64) arch="x64" ;;
    aarch64|arm64) arch="arm64" ;;
    *) echo "Unsupported architecture for lua-language-server: $(uname -m)" >&2; return 1 ;;
  esac

  tag="$(curl -fsSL https://api.github.com/repos/LuaLS/lua-language-server/releases/latest | grep -m1 '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/')"
  [[ -n "$tag" ]] || { echo "Could not determine latest lua-language-server release" >&2; return 1; }

  url="https://github.com/LuaLS/lua-language-server/releases/download/${tag}/lua-language-server-${tag#v}-linux-${arch}.tar.gz"
  install_dir="$HOME/.local/share/lua-language-server"
  mkdir -p "$install_dir" "$HOME/.local/bin"

  curl -fsSL "$url" -o /tmp/lua-language-server.tar.gz
  tar -xzf /tmp/lua-language-server.tar.gz -C "$install_dir"
  rm -f /tmp/lua-language-server.tar.gz
  ln -sf "$install_dir/bin/lua-language-server" "$HOME/.local/bin/lua-language-server"
  echo "Installed lua-language-server ${tag} -> $HOME/.local/bin/lua-language-server (make sure ~/.local/bin is on PATH)"
}

[[ "$OS" == "Linux" ]] && have dnf && install_lua_ls_from_release

# ---------------------------------------------------------------------------
# 3. Node-based LSP servers (identical on both platforms)
# ---------------------------------------------------------------------------

if have npm; then
  log "Installing pyright, typescript, typescript-language-server via npm"
  # typescript is pinned to the 5.x stable line: the newer v7 native compiler
  # removed the classic tsserver.js that typescript-language-server needs.
  npm install -g pyright typescript@5 typescript-language-server
else
  echo "npm not found - skipping pyright/typescript-language-server install" >&2
fi

# ---------------------------------------------------------------------------
# 4. gopls (needs the Go toolchain, installed above)
# ---------------------------------------------------------------------------

if have go; then
  log "Installing gopls"
  GOBIN="${GOBIN:-$(go env GOPATH)/bin}"
  mkdir -p "$GOBIN"
  GOBIN="$GOBIN" go install golang.org/x/tools/gopls@latest
  echo "Installed gopls -> $GOBIN/gopls (make sure it's on PATH)"
else
  echo "go not found - skipping gopls install" >&2
fi

log "Done. Verify with: nvim --headless -c 'qa!' and opening a .lua/.py/.js/.go file to confirm LSP clients attach."
