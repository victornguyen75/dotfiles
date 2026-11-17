#!/usr/bin/env bash
# Bootstrap this dotfiles stack inside WSL (Ubuntu): Homebrew on Linux, fish,
# tmux, Neovim, and the repo's symlinks. Safe to re-run.
#
# Usage (from a fresh Ubuntu shell in WSL):
#   curl -fsSL https://raw.githubusercontent.com/victornguyen75/dotfiles/main/scripts/bootstrap-wsl.sh | bash
# or, after cloning:
#   ~/.dotfiles/scripts/bootstrap-wsl.sh
#
# Set DOTFILES_BRANCH to clone a branch other than main.
set -euo pipefail

DOTFILES="$HOME/.dotfiles"
DOTFILES_REPO="https://github.com/victornguyen75/dotfiles.git"
DOTFILES_BRANCH="${DOTFILES_BRANCH:-main}"
BREW="/home/linuxbrew/.linuxbrew/bin/brew"

step() { printf '\n==> %s\n' "$*"; }

if ! grep -qi microsoft /proc/version 2>/dev/null; then
  echo "This script is for WSL. On macOS, follow the README's Mac section." >&2
  exit 1
fi

step "apt prerequisites (Homebrew build deps, unzip for Mason, locale for fish's LANG)"
sudo apt-get update
sudo apt-get install -y build-essential procps curl file git unzip locales
sudo locale-gen en_US.UTF-8

step "Homebrew on Linux"
if [ ! -x "$BREW" ]; then
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$("$BREW" shellenv)"

step "Clone dotfiles into $DOTFILES"
if [ ! -d "$DOTFILES/.git" ]; then
  git clone --branch "$DOTFILES_BRANCH" "$DOTFILES_REPO" "$DOTFILES"
fi

step "brew bundle (casks are skipped on Linux)"
brew bundle --file "$DOTFILES/Brewfile"

step "Symlink configs (existing files are moved to *.bak.<timestamp>)"
link() {
  local src="$1" dst="$2"
  mkdir -p "$(dirname "$dst")"
  if [ -L "$dst" ]; then
    ln -sfn "$src" "$dst"
  elif [ -e "$dst" ]; then
    mv "$dst" "$dst.bak.$(date +%s)"
    ln -s "$src" "$dst"
  else
    ln -s "$src" "$dst"
  fi
  echo "  $dst -> $src"
}
link "$DOTFILES/.gitconfig" "$HOME/.gitconfig"
link "$DOTFILES/.tmux.conf" "$HOME/.tmux.conf"
link "$DOTFILES/nvim" "$HOME/.config/nvim"
link "$DOTFILES/fish" "$HOME/.config/fish"
# .wezterm.lua is read by WezTerm on the Windows side, not from WSL.

step "Make Homebrew's fish the login shell"
FISH="$(brew --prefix)/bin/fish"
grep -qxF "$FISH" /etc/shells || echo "$FISH" | sudo tee -a /etc/shells >/dev/null
if [ "$(getent passwd "$USER" | cut -d: -f7)" != "$FISH" ]; then
  sudo chsh -s "$FISH" "$USER"
fi

step "TPM and tmux plugins"
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi
tmux new-session -d -s plugins-install \; \
  run-shell "$HOME/.tmux/plugins/tpm/bin/install_plugins" \; \
  kill-session -t plugins-install

step "Fisher plugins and Node LTS (Mason needs Node)"
fish -c '
  curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
  fisher update
  nvm install lts
  set -U nvm_default_version lts
'

step "Claude Code (native Linux build in ~/.local/bin; the Windows claude.exe doesn't run as 'claude' here)"
if [ ! -x "$HOME/.local/bin/claude" ]; then
  curl -fsSL https://claude.ai/install.sh | bash
fi

cat <<EOF

Done. Remaining manual steps:
  1. git -C ~/.dotfiles status   # Fisher can delete files it doesn't manage; restore with git checkout -- <path>
  2. gh auth login               # .gitconfig uses gh for GitHub HTTPS auth
  3. nvim                        # let LazyVim install plugins, LSPs, formatters
  4. claude                      # sign in to Claude Code once inside WSL
  5. Recreate local secrets (~/.config/fish/secrets.fish, ~/.secrets.env)
  6. Close and reopen WezTerm: it now starts in WSL:Ubuntu.
EOF
