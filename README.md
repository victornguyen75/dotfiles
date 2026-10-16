# Beyond Dotfiles in 100 Seconds

[![Video thumbnail with link to video...might not need the header line because of this](./dotfiles-in-100-seconds-cover.jpg)](https://youtu.be/r_MpUP6aKiQ 'Dotfiles in 100 Seconds on YouTube')

Watch the [video collaboration](https://youtu.be/r_MpUP6aKiQ 'Dotfiles in 100 Seconds on YouTube') between [fireship.io](https://fireship.io/ 'Build and ship 🔥 your app ⚡ faster') and [eieio.xyz](http://dotfiles.eieio.xyz 'Dotfiles from Start to Finish-ish'). And don't forget to [subscribe](https://fireship.page.link/youtube 'Fireship YouTube Channel') while you're there!

Then, go **_way_** beyond 100 seconds by taking the full course on Udemy, [**_Dotfiles from Start to Finish-ish_**](https://www.udemy.com/course/dotfiles-from-start-to-finish-ish/?referralCode=445BE0B541C48FE85276 'Learn Dotfiles from Start to Finish-ish on Udemy') (aka "Dotiles in 15240 Seconds and Growing"). Keep an eye on [Twitter](https://twitter.com/EIEIOxyz '@EIEIOxyz') and [YouTube](https://www.youtube.com/channel/UCcZZOzRKMbql7IEL0midfgQ 'EIEIO YouTube Channel') for updates to the course.

> **Agent note:** if you're helping someone onboard this repo, use
> [`.github/skills/dotfiles-onboarding/SKILL.md`](./.github/skills/dotfiles-onboarding/SKILL.md)
> for the cross-platform setup playbook.

## Steps to bootstrap a new Windows

Windows should target the same **terminal-first workflow** as macOS:
**WezTerm + tmux + Neovim**, with fish as the shell inside that stack.
Prefer that path over day-to-day PowerShell or `cmd`, and treat WSL as optional,
not the default.

1. Install the base tools:
   - [Git for Windows](https://git-scm.com/download/win 'Download Git for Windows')
   - [WezTerm](https://wezfurlong.org/wezterm/)
   - a Unix-like userland on Windows that can run `tmux`, `fish`, and `nvim`
     natively. **MSYS2** is the preferred starting point.

2. Clone the repo into a hidden home directory checkout from Git Bash or your
   Unix-like Windows shell.

```bash
# Use SSH (if set up)...
git clone git@github.com:eieioxyz/Beyond-Dotfiles-in-100-Seconds.git ~/.dotfiles

# ...or use HTTPS and switch remotes later.
git clone https://github.com/victornguyen75/dotfiles.git ~/.dotfiles
```

1. Symlink the configs you want to manage from this repo.

```bash
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
ln -s ~/.dotfiles/.wezterm.lua ~/.wezterm.lua
ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/.dotfiles/nvim ~/.config/nvim
ln -s ~/.dotfiles/fish ~/.config/fish
```

> If Windows blocks symlink creation, enable Developer Mode so non-admin
> symlinks work more reliably.

1. Install the terminal workflow packages from your Windows Unix layer. With
   MSYS2, that means using `pacman` to install at least `tmux`, `neovim`,
   `fish`, `git`, `curl`, `ripgrep`, and `fzf`.

```bash
pacman -S --needed tmux neovim fish git curl ripgrep fzf
```

1. Install OMF (Oh My Fish) if you want the same fish plugin workflow.

```bash
curl -L https://get.oh-my.fish | fish
```

1. Install [TPM](https://github.com/tmux-plugins/tpm) (tmux Plugin Manager) and
   bootstrap the tmux plugins.

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux new-session -d -s plugins-install \; run-shell '~/.tmux/plugins/tpm/bin/install_plugins' \; kill-session -t plugins-install
```

1. Launch `nvim` once to let LazyVim install plugins and language tooling.

```bash
nvim
```

The goal on Windows is still the same as on macOS: open **WezTerm**, attach to
**tmux**, and work from there.

## Steps to bootstrap a new Mac

macOS is the clearest expression of this repo's preferred setup:
**WezTerm + tmux + Neovim**, with fish as the shell throughout.

If you want the full terminal-first workflow, treat this section as the canonical
bootstrap path and [`WORKFLOW.md`](./WORKFLOW.md) as the day-to-day usage guide.

1. Install Apple's Command Line Tools, which are prerequisites for Git and Homebrew.

```bash
xcode-select --install
```

1. Clone the repo into a hidden home-directory checkout.

```bash
# Use SSH (if set up)...
git clone git@github.com:eieioxyz/Beyond-Dotfiles-in-100-Seconds.git ~/.dotfiles

# ...or use HTTPS and switch remotes later.
git clone https://github.com/victornguyen75/dotfiles.git ~/.dotfiles
```

1. Install Homebrew, then use the repo's `Brewfile` as the default package source.

```bash
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install everything declared by the repo
brew bundle --file ~/.dotfiles/Brewfile

# ...or move to the directory first.
cd ~/.dotfiles && brew bundle
```

1. Symlink the repo-managed config into `$HOME` and `~/.config`.

```bash
ln -s ~/.dotfiles/.zshrc ~/.zshrc
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
ln -s ~/.dotfiles/.wezterm.lua ~/.wezterm.lua
ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/.dotfiles/nvim ~/.config/nvim
ln -s ~/.dotfiles/fish ~/.config/fish
```

> Before symlinking, back up any existing local files instead of overwriting them blindly.

1. Install any terminal-workflow packages that are not already covered by the `Brewfile`.

```bash
brew install neovim tmux wezterm ripgrep fd fzf lazygit bat fish nvm
brew install --cask font-jetbrains-mono-nerd-font
```

1. Make fish the default shell.

```bash
which fish
chsh -s "$(which fish)"
```

1. Install OMF (Oh My Fish) and fish-side NVM integration if you want the same plugin workflow used elsewhere in this repo.

```bash
curl -L https://get.oh-my.fish | fish

# This plugin allows Fish to work with NVM
omf install nvm

# Sets the NVM directory
set -gx NVM_DIR (brew --prefix nvm)
```

1. Install [TPM](https://github.com/tmux-plugins/tpm) (tmux Plugin Manager) and bootstrap the tmux plugins.

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux new-session -d -s plugins-install \; run-shell '~/.tmux/plugins/tpm/bin/install_plugins' \; kill-session -t plugins-install
```

1. Launch `nvim` once to let LazyVim / `lazy.nvim` install plugins, LSP servers, and formatters.

```bash
nvim
```

Then run `:LspCopilotSignIn` once to authenticate GitHub Copilot via device-flow OAuth.

 1. Restore local-only secrets manually. Do **not** put them in tracked files.

Recreate these locally as needed:

- `~/.config/fish/secrets.fish`
- `~/.secrets.env`
- any machine-specific SSH, npm, GitHub, or cloud credentials
- fish universal variables / `fish_variables`

 1. Validate the setup.

```bash
git --version
fish --version
tmux -V
nvim --version
wezterm --version
```

Also verify that:

- the symlinks point into `~/.dotfiles`
- WezTerm picks up `.wezterm.lua`
- `fish` starts cleanly
- `tmux` loads plugins successfully
- `nvim` opens without startup errors
- the `tm` fish helper works from a project directory

## VSCode Extensions

- Beautify (hookyqr.beautify)
- C/C++ (ms-vscode.cpptools)
- ES7 React (dsznajder.es7-react-js-snippets)
- Eslint (dbaeumer.vscode-eslint)
- GitLens (eamodio.gitlens)
- GraphQL (kumar-harsh.graphql-for-vscode)
- Prettier (esbenp.prettier-vscode)
- Pylance (ms-python.vscode-pylance)
- Python (ms-python.python)
- vscode-styled-component (jpoissonnier.vscode-styled-components)

## Terminal-only workflow: WezTerm + tmux + Neovim (LazyVim)

Victor's stack for a fully terminal-based dev workflow, running alongside VSCode
during a gradual migration. fish stays the shell in every layer.

> **Bootstrap first, then use this daily:** the macOS and Windows sections above
> now cover the setup steps. See [`WORKFLOW.md`](./WORKFLOW.md) for keybindings,
> the `tm` entry point, and the day-to-day operating model.

A few workflow-specific notes that are still worth calling out here:

- **Copilot in Neovim:** after the first `nvim` launch, run
  `:LspCopilotSignIn` once to authenticate GitHub Copilot via device-flow OAuth.
- **Secrets stay local:** keep tokens/keys out of tracked shell files. Recreate
  `~/.config/fish/secrets.fish`, `~/.secrets.env`, and any fish universal vars
  locally on each machine.
- **Corporate proxy note:** if you're behind a TLS-intercepting corporate proxy
  (for example Zscaler), `npm`/Mason installs may fail with
  `UNABLE_TO_GET_ISSUER_CERT_LOCALLY`. `NODE_OPTIONS=--use-system-ca` (set in
  both `fish/config.fish` and `.bashrc`) tells Node (>=22) to trust the same CA
  store as the rest of macOS.
- **Daily entry point:** the `tm` fish function (`fish/functions/tm.fish`)
  attaches to an existing tmux session named after the current directory, or
  creates one if it doesn't exist yet.

## TODO List for Windows Configurations

- Learn how to install scripts and bootstrapping tools for windows

## TODO List for MacOS Configurations

- Learn how to use [`defaults`](https://macos-defaults.com/#%F0%9F%99%8B-what-s-a-defaults-command) to record and restore System Preferences and other macOS configurations.
- Organize these growing steps into multiple script files.
- Automate symlinking and run script files with a bootstrapping tool like [Dotbot](https://github.com/anishathalye/dotbot).
- Revisit the list in [`.zshrc`](.zshrc) to customize the shell.
- Make a checklist of steps to decommission your computer before wiping your hard drive.
- Create a [bootable USB installer for macOS](https://support.apple.com/en-us/HT201372).
- Integrate other cloud services into your Dotfiles process (Dropbox, Google Drive, etc.).
- Find inspiration and examples in other Dotfiles repositories at [dotfiles.github.io](https://dotfiles.github.io/).
- And last, but hopefully not least, [**take my course, _Dotfiles from Start to Finish-ish_**](https://www.udemy.com/course/dotfiles-from-start-to-finish-ish/?referralCode=445BE0B541C48FE85276 'Learn Dotfiles from Start to Finish-ish on Udemy')!
