#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
NVIM_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"

# ── Detect OS ──────────────────────────────────────────────────────────────────
OS="$(uname -s)"
case "$OS" in
  Darwin) PLATFORM="mac" ;;
  Linux)  PLATFORM="linux" ;;
  *)      echo "Unsupported OS: $OS"; exit 1 ;;
esac

echo "Detected platform: $PLATFORM"

# ── Homebrew (required on Mac; optional but used on Linux too) ─────────────────
install_brew() {
  if command -v brew &>/dev/null; then
    echo "Homebrew already installed."
    return
  fi
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # Add brew to PATH for this session
  if [[ "$PLATFORM" == "mac" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /usr/local/bin/brew shellenv)"
  else
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >>"$HOME/.profile"
  fi
}

# ── macOS dependencies ─────────────────────────────────────────────────────────
install_mac_deps() {
  install_brew
  echo "Installing macOS dependencies via Homebrew..."
  brew install neovim ripgrep fd cmake git glow go
  # Node via mise (see install_mise below)
  # Python via mise (see install_mise below)
}

# ── Linux dependencies ─────────────────────────────────────────────────────────
install_linux_deps() {
  echo "Installing Linux dependencies..."
  sudo apt-get update -y
  sudo apt-get install -y \
    build-essential procps wget file git cmake unzip \
    python3-pip python3-venv xclip curl golang-go

  # Neovim: install latest stable via snap or appimage
  if command -v snap &>/dev/null; then
    sudo snap install nvim --classic
  else
    echo "Installing Neovim appimage..."
    local nvim_url="https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz"
    local tmp_dir
    tmp_dir=$(mktemp -d)
    wget -q -O "$tmp_dir/nvim.tar.gz" "$nvim_url"
    tar xzf "$tmp_dir/nvim.tar.gz" -C "$tmp_dir"
    sudo mv "$tmp_dir/nvim-linux64/bin/nvim" /usr/local/bin/
    sudo mv "$tmp_dir/nvim-linux64/lib/nvim/"  /usr/local/lib/ 2>/dev/null || true
    sudo mv "$tmp_dir/nvim-linux64/share/nvim" /usr/local/share/ 2>/dev/null || true
    rm -rf "$tmp_dir"
  fi

  # ripgrep, fd, glow via brew (linuxbrew)
  install_brew
  brew install ripgrep fd glow cmake
}

# ── mise (runtime version manager: Python, Node, etc.) ────────────────────────
install_mise() {
  if command -v mise &>/dev/null; then
    echo "mise already installed."
    return
  fi
  echo "Installing mise..."
  curl https://mise.run | sh
  export PATH="$HOME/.local/bin:$PATH"
}

# ── direnv ────────────────────────────────────────────────────────────────────
install_direnv() {
  if command -v direnv &>/dev/null; then
    echo "direnv already installed."
    return
  fi
  echo "Installing direnv..."
  if [[ "$PLATFORM" == "mac" ]]; then
    brew install direnv
  else
    sudo apt-get install -y direnv 2>/dev/null || brew install direnv
  fi
}

# ── Install NoobVim config ─────────────────────────────────────────────────────
install_noobvim() {
  echo "Installing NoobVim config to $NVIM_CONFIG_DIR..."
  if [[ -d "$NVIM_CONFIG_DIR" && "$NVIM_CONFIG_DIR" != "$REPO_ROOT" ]]; then
    local backup="${NVIM_CONFIG_DIR}.bak.$(date +%Y%m%d%H%M%S)"
    echo "Existing config found — backing up to $backup"
    mv "$NVIM_CONFIG_DIR" "$backup"
  fi

  if [[ "$NVIM_CONFIG_DIR" == "$REPO_ROOT" ]]; then
    echo "Running from config directory — skipping copy."
  else
    mkdir -p "$(dirname "$NVIM_CONFIG_DIR")"
    cp -r "$REPO_ROOT" "$NVIM_CONFIG_DIR"
  fi
}

# ── Headless plugin install via lazy.nvim ─────────────────────────────────────
install_plugins() {
  echo "Installing plugins (headless)..."
  nvim --headless "+Lazy! sync" +qa
  echo "Installing Treesitter parsers..."
  nvim --headless -c 'TSUpdateSync' -c 'sleep 450' -c 'quit' 2>/dev/null || true
  echo "Installing Mason tools (debugpy, js-debug-adapter)..."
  nvim --headless -c 'MasonInstall debugpy js-debug-adapter' -c 'sleep 10' -c 'qall' 2>/dev/null || true
}

# ── Main ───────────────────────────────────────────────────────────────────────
echo "═══════════════════════════════════════════"
echo "         NoobVim Installer"
echo "═══════════════════════════════════════════"

if [[ "$PLATFORM" == "mac" ]]; then
  install_mac_deps
else
  install_linux_deps
fi

install_mise
install_direnv
install_noobvim
install_plugins

echo ""
echo "✓ NoobVim installed successfully!"
echo ""
echo "  Next steps:"
echo "  1. Restart your terminal (or source your shell profile)"
echo "  2. Run: nvim"
echo "  3. Wait for lazy.nvim to finish installing plugins"
echo ""
if [[ "$PLATFORM" == "mac" ]]; then
  echo "  Tip: Install a Nerd Font via: brew install --cask font-jetbrains-mono-nerd-font"
fi
