# Secrets (ARTIFACTORY_TOKEN, etc.) live in an untracked, gitignored file so they
# never end up committed to the dotfiles repo.
[ -f "$HOME/.secrets.env" ] && source "$HOME/.secrets.env"
[ -f "$HOME/.rover/env" ] && source "$HOME/.rover/env"
