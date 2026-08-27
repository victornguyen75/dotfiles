# Secrets (NPM_TOKEN, etc.) live in an untracked, gitignored file so they never end
# up committed to the dotfiles repo.
[ -f "$HOME/.secrets.env" ] && source "$HOME/.secrets.env"
export HOMEBREW_FORCE_BREWED_CURL=1
# Corporate Zscaler proxy: make Node/npm trust the system CA store (see fish config.fish)
export NODE_OPTIONS="--use-system-ca"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

source "/Users/victor/.rover/env"
