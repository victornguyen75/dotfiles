---
name: dotfiles-onboarding
description: Help an agent bootstrap this dotfiles setup on a new machine across macOS, Windows, or Linux. Use when onboarding the repo, symlinking managed config files, installing terminal/editor dependencies, restoring shell tooling, or adapting the workflow to a different OS.
---

# Onboarding this dotfiles setup across macOS, Windows, and Linux

This repo is the source of truth for a terminal-first developer setup built around:

- shell dotfiles in the repo root (`.zshrc`, `.bashrc`, `.gitconfig`, etc.)
- fish config in `fish/`
- Neovim config in `nvim/`
- tmux config in `.tmux.conf`
- WezTerm config in `.wezterm.lua`
- package installation on macOS via `Brewfile`

Use this skill when the task is to help someone set up this environment on a new machine, migrate to it gradually, or adapt the repo for a different operating system.

## First: choose the right onboarding path

Use this decision tree before giving commands:

- **macOS** → use the native path. This repo already documents macOS clearly.
- **Linux** → use the native path, but adapt package installation to the distro.
- **Windows** → prefer a **native Windows terminal stack built around WezTerm + tmux + Neovim**.
  - Prefer WezTerm as the terminal.
  - Prefer tmux as the session/workspace layer.
  - Prefer a Unix-like Windows userland that can run `tmux`, `fish`, and `nvim` natively; **MSYS2** is the default recommendation.
  - Do **not** default to WSL, PowerShell, or `cmd` for the primary workflow unless the user explicitly asks for them or native setup is blocked.

If the user says only “Linux,” ask which distro before giving package-manager-specific commands.

## Core principles for every OS

1. **Clone the repo into a hidden home-directory checkout**.
   - Preferred path: `~/.dotfiles` on macOS/Linux/WSL.
   - Windows native equivalent: `$HOME/.dotfiles` or `$env:USERPROFILE\.dotfiles`.
2. **Symlink from the home directory into the repo** instead of copying tracked files.
3. **Treat secrets as local-only**.
   - Never store tokens or machine-specific secrets in tracked files.
   - Recreate these locally on each machine:
     - `~/.config/fish/secrets.fish`
     - `~/.secrets.env`
     - fish universal variables / `fish_variables`
4. **Bootstrap in layers**.
   - First: Git + clone + symlinks
   - Then: shell/tools
   - Then: tmux/plugins
   - Then: Neovim/LazyVim/Copilot auth
5. **Prefer repo-aligned config locations**.
   - `~/.wezterm.lua` → `.wezterm.lua`
   - `~/.tmux.conf` → `.tmux.conf`
   - `~/.config/nvim` → `nvim/`
   - `~/.config/fish` → `fish/`

## Shared checklist for any OS

Use this as the standard flow.

### 1) Install Git and clone the repo

SSH if available:

```bash
git clone git@github.com:eieioxyz/Beyond-Dotfiles-in-100-Seconds.git ~/.dotfiles
```

HTTPS fallback:

```bash
git clone https://github.com/victornguyen75/dotfiles.git ~/.dotfiles
```

### 2) Create the core symlinks

At minimum:

```bash
ln -s ~/.dotfiles/.zshrc ~/.zshrc
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
```

For the terminal-first workflow, also link:

```bash
ln -s ~/.dotfiles/.wezterm.lua ~/.wezterm.lua
ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/.dotfiles/nvim ~/.config/nvim
ln -s ~/.dotfiles/fish ~/.config/fish
```

Before creating links, check whether the destination already exists. If it does,
back it up first instead of overwriting blindly.

### 3) Restore local-only secrets

Recreate these by hand from the old machine or a secure secret source:

- `~/.config/fish/secrets.fish`
- `~/.secrets.env`
- any untracked SSH, npm, GitHub, or cloud credentials

Do **not** commit any of them to this repo.

### 4) Bootstrap tmux + Neovim plugins

Install TPM:

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Install tmux plugins:

```bash
tmux new-session -d -s plugins-install \; run-shell '~/.tmux/plugins/tpm/bin/install_plugins' \; kill-session -t plugins-install
```

Then launch Neovim once:

```bash
nvim
```

This allows LazyVim / lazy.nvim to install plugins, LSP servers, and formatters.

### 5) Validate the setup

Check the basics:

```bash
git --version
fish --version
tmux -V
nvim --version
wezterm --version
```

Also verify that:

- the symlinks point into `~/.dotfiles`
- `fish` starts cleanly
- `tm` works from a project directory if fish functions loaded correctly
- Neovim opens without startup errors
- tmux pane navigation and plugin loading work

## macOS path

This is the most complete and best-supported path in the repo today.

### Preflight

Install Apple command-line tools:

```bash
xcode-select --install
```

### Package management

Install Homebrew:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Install repo-managed packages:

```bash
brew bundle --file ~/.dotfiles/Brewfile
```

Or:

```bash
cd ~/.dotfiles && brew bundle
```

### Terminal workflow packages

If they are not already covered by the Brewfile, install:

```bash
brew install neovim tmux wezterm ripgrep fd fzf lazygit bat fish
brew install --cask font-jetbrains-mono-nerd-font
```

### Make fish the default shell

Use the actual installed fish path rather than assuming `/usr/local/bin/fish`:

```bash
which fish
chsh -s "$(which fish)"
```

### Fish plugins

Install Oh My Fish:

```bash
curl -L https://get.oh-my.fish | fish
omf install nvm
set -gx NVM_DIR (brew --prefix nvm)
```

### Final macOS-specific checks

- WezTerm launches and picks up `.wezterm.lua`
- clipboard works through tmux + Neovim
- `:LspCopilotSignIn` succeeds in Neovim
- Homebrew-installed tools are on PATH in fish

## Linux path

Linux is supported conceptually, but package installation must be adapted per distro.

### Recommended approach

Use the same clone + symlink pattern as macOS. The main difference is package installation.

### Ask or detect the distro first

Common mappings:

- **Ubuntu/Debian** → `apt`
- **Fedora** → `dnf`
- **Arch** → `pacman`

### Install the common toolchain

Install equivalents for:

- `git`
- `curl`
- `fish`
- `tmux`
- `neovim`
- `ripgrep`
- `fd` / `fd-find`
- `fzf`
- `bat`
- `lazygit`
- `wezterm` if available for the distro

Example shape for Ubuntu/Debian:

```bash
sudo apt update
sudo apt install -y git curl fish tmux neovim ripgrep fzf bat
```

Notes:

- On Debian/Ubuntu, `fd` is often packaged as `fd-find`.
- `wezterm` may require an external repo, AppImage, Flatpak, or manual install.
- If WezTerm is unavailable, use another terminal emulator temporarily and keep the rest of the stack.

### Make fish the default shell

```bash
chsh -s "$(command -v fish)"
```

If `chsh` rejects the shell, ensure the fish path is listed in `/etc/shells`.

### Fish plugins

Install Oh My Fish if desired:

```bash
curl -L https://get.oh-my.fish | fish
```

If `nvm` integration is needed, adapt the fish plugin setup to the Linux install location rather than assuming Homebrew paths.

### Final Linux-specific checks

- Neovim can install plugins and LSP tools successfully
- PATHs resolve correctly in fish
- tmux true-color and clipboard behavior work in the chosen terminal
- if behind a corporate proxy, npm/Mason certificate issues may need local CA configuration

## Windows path

For Windows, guide users toward a **native WezTerm + tmux workflow first**.
WSL is a fallback or alternative, not the default recommendation.

## Preferred Windows path: WezTerm + tmux + native Unix-like userland

### Why this is preferred

It keeps the day-to-day experience aligned with the rest of this repo:
WezTerm as the terminal, tmux as the persistent workspace layer, fish as the
shell, and Neovim as the editor.

### Default recommendation

Recommend this stack first:

1. **WezTerm** as the terminal emulator.
2. **MSYS2** as the native Unix-like userland on Windows.
3. **tmux**, **fish**, and **Neovim** installed inside that environment.
4. Repo-managed config symlinked into the Windows home directory and config directories.

### Flow

1. Install **Git for Windows**.
2. Install **WezTerm**.
3. Install **MSYS2**.
4. Clone this repo into the home directory as `~/.dotfiles` from Git Bash or the MSYS2 shell.
5. Symlink `.gitconfig`, `.wezterm.lua`, `.tmux.conf`, `nvim/`, and `fish/` into place.
6. Install `tmux`, `fish`, `neovim`, and supporting CLI tools in MSYS2.
7. Install TPM and bootstrap Neovim plugins.

### Repo placement

Prefer:

```bash
git clone git@github.com:eieioxyz/Beyond-Dotfiles-in-100-Seconds.git ~/.dotfiles
```

### Symlink notes

- Windows symlink creation may require Developer Mode or elevated privileges.
- Do not assume `ln -s` behaves identically across Git Bash, MSYS2, and other shells.
- If symlink creation is blocked, explain the constraint and use the smallest temporary workaround, but keep symlinks as the preferred end state.

### Command style guidance

- Prefer commands that run from Git Bash or the MSYS2 shell.
- Do **not** center PowerShell or `cmd` in the workflow unless the user explicitly asks for them.
- Treat WSL as optional only when native Windows tooling cannot satisfy the requested workflow.

## Alternate Windows path: WSL on request or as fallback

Use WSL only when:

- the user explicitly wants it, or
- native Windows tooling cannot provide a workable `tmux` + `fish` + `nvim` setup.

In that case, follow the **Linux path** inside WSL and optionally keep WezTerm on Windows as the terminal frontend.

## What to read before giving detailed help

When helping with onboarding, read these repo docs first:

- `README.md` — bootstrap steps, symlink examples, package notes, secrets guidance
- `WORKFLOW.md` — day-to-day tmux + Neovim workflow after bootstrap

## Agent behavior guidance

When using this skill, the agent should:

1. Identify the target OS first.
2. Ask one clarifying question when Linux distro or Windows mode is ambiguous.
3. Prefer the smallest safe set of commands.
4. Warn before replacing existing dotfiles.
5. Keep secrets out of tracked files.
6. Call out when an instruction is macOS-specific and offer the Linux/Windows analogue.
7. Prefer WSL over native Windows for the full terminal stack.

## Good outcomes

A successful onboarding ends with:

- the repo cloned locally
- symlinks created for the intended config files
- fish, tmux, Neovim, and optionally WezTerm installed
- tmux plugins installed
- Neovim plugins bootstrapped
- secrets restored locally
- the user able to open a terminal, run `tm`, and edit in `nvim`
