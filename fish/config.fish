if status is-interactive
    # Commands to run in interactive sessions can go here
    set -x LANG en_US.UTF-8
end

# Corporate Zscaler proxy intercepts TLS; Node/npm don't trust the system CA
# store by default (unlike curl), causing UNABLE_TO_GET_ISSUER_CERT_LOCALLY on
# npm installs (e.g. Neovim's Mason LSP/formatter installs). This tells Node to
# use the same trust store as the rest of macOS.
set -x NODE_OPTIONS --use-system-ca

function code
  set location "$PWD/$argv"
  open -n -b "com.microsoft.VSCode" --args $location
end


# Secrets (ARTIFACTORY_TOKEN, etc.) live in an untracked, gitignored file so they
# never end up committed to the dotfiles repo.
if test -f ~/.config/fish/secrets.fish
    source ~/.config/fish/secrets.fish
end
alias ag='open -a "Antigravity"'


# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# Created by `pipx` on 2026-06-11 16:51:42
set PATH $PATH /Users/victor/.local/bin
