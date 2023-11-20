# Beyond Dotfiles in 100 Seconds

[![Video thumbnail with link to video...might not need the header line because of this](./dotfiles-in-100-seconds-cover.jpg)](https://youtu.be/r_MpUP6aKiQ 'Dotfiles in 100 Seconds on YouTube')

Watch the [video collaboration](https://youtu.be/r_MpUP6aKiQ 'Dotfiles in 100 Seconds on YouTube') between [fireship.io](https://fireship.io/ 'Build and ship 🔥 your app ⚡ faster') and [eieio.xyz](http://dotfiles.eieio.xyz 'Dotfiles from Start to Finish-ish'). And don't forget to [subscribe](https://fireship.page.link/youtube 'Fireship YouTube Channel') while you're there!

Then, go **_way_** beyond 100 seconds by taking the full course on Udemy, [**_Dotfiles from Start to Finish-ish_**](https://www.udemy.com/course/dotfiles-from-start-to-finish-ish/?referralCode=445BE0B541C48FE85276 'Learn Dotfiles from Start to Finish-ish on Udemy') (aka "Dotiles in 15240 Seconds and Growing"). Keep an eye on [Twitter](https://twitter.com/EIEIOxyz '@EIEIOxyz') and [YouTube](https://www.youtube.com/channel/UCcZZOzRKMbql7IEL0midfgQ 'EIEIO YouTube Channel') for updates to the course.

## Steps to bootstrap a new Windows

1. [Install Git to use Git Bash](https://git-scm.com/download/win 'Download Git for Windows')

2. Clone repo into a new hidden directory with Git Bash, Command Prompt, or Powershell.

```bash
# Use SSH (if set up)...
git clone git@github.com:eieioxyz/Beyond-Dotfiles-in-100-Seconds.git ~/.dotfiles

# ...or use HTTPS and switch remotes later.
git clone https://github.com/victornguyen75/dotfiles.git ~/.dotfiles
```

3. Create symlinks in the Home directory to the real files in the repo.

```bash
# There are better and less manual ways to do this;
# investigate install scripts and bootstrapping tools.

ln -s ~/.dotfiles/.zshrc ~/.zshrc
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
```

4. Install Linux Subsystem (If you want Fish)

There are many ways to install WLS. I'll show the easiest.

```
1. Firstly, launch Settings
2. Then, tap on Applications.
3. After that, tap the ‘Programs and Features’ option. It shall be located under the ‘Related settings’ part.
4. Next, tap on a ‘Turn Windows features on or off’ tab.
5. Then, put a tick on the Windows Subsystem for Linux square.
6. After that, tap on the OK option.
7. Lastly, tap on the Restart now option.
8. Run Bash on Windows
9. Open a command prompt (CMD). Type “cmd” in the start.
10. Type bash and hit enter.
11. You will be prompt to accept the license. just type y and hit enter.
12. After you have accepted the License, the Ubuntu user-mode image will be downloaded and a “Bash on Ubuntu on Windows” shortcut will be added to your start menu.
13. To launch Bash on Windows, either run bash at a cmd/PowerShell command-prompt, or use the start menu shortcut.
```

5. Install Fish (the Friendly-Interactive Shell)

```bash
# Install fish repository
$ sudo apt-add-repository ppa:fish-shell/release-3

# Update and upgrade repository
$ sudo apt-get update && sudo apt-get upgrade

# Install fish shell
$ sudo apt-get install fish
```

6. Install OMF (Oh My Fish)

```
curl -L https://get.oh-my.fish | fish

# This plugin allows Fish to work with NVM
omf install nvm

# Sets the NVM directory
set -gx NVM_DIR (brew --prefix nvm)
```

## Steps to bootstrap a new Mac

1. Install Apple's Command Line Tools, which are prerequisites for Git and Homebrew.

```bash
xcode-select --install
```

2. Clone repo into new hidden directory.

```bash
# Use SSH (if set up)...
git clone git@github.com:eieioxyz/Beyond-Dotfiles-in-100-Seconds.git ~/.dotfiles

# ...or use HTTPS and switch remotes later.
git clone https://github.com/victornguyen75/dotfiles.git ~/.dotfiles
```

3. Create symlinks in the Home directory to the real files in the repo.

```bash
# There are better and less manual ways to do this;
# investigate install scripts and bootstrapping tools.

ln -s ~/.dotfiles/.zshrc ~/.zshrc
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
```

4. Install Homebrew, followed by the software listed in the Brewfile.

```bash
# These could also be in an install script.

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Then pass in the Brewfile location...
brew bundle --file ~/.dotfiles/Brewfile

# ...or move to the directory first.
cd ~/.dotfiles && brew bundle
```

5. Install NVM (Node Version Manager)

```
brew install nvm
```

6. Install Fish (the friendly-interactive shell)

```
brew install fish

# Make fish the default shell
sudo chsh -s /usr/local/bin/fish

# Do this if for some reason your path to fish is different:
# sudo chsh -s (which fish)

```

7. Install OMF (Oh My Fish)

```
curl -L https://get.oh-my.fish | fish

# This plugin allows Fish to work with NVM
omf install nvm

# Sets the NVM directory
set -gx NVM_DIR (brew --prefix nvm)
```

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
