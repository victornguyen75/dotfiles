# Terminal-Only Workflow: Onboarding Guide

WezTerm + tmux + Neovim (LazyVim), running alongside VSCode during a gradual,
project-by-project migration. fish stays the shell throughout.

## 1. First-time setup (do this once)

1. Merge the PR that introduced these configs (or pull `main` after it's merged) —
   your live machine already has everything symlinked, but this repo is the source
   of truth going forward for any new machine.
2. Launch **WezTerm** and pin it to your Dock (macOS) or taskbar (Windows).
3. Open WezTerm → it launches straight into fish. Run `nvim` once to finish
   installing plugins. On macOS, also run `:LspCopilotSignIn` to authenticate Copilot
   (one-time GitHub device-flow login, same subscription as VSCode's Copilot Chat).
   Copilot is Mac-only; Windows skips it.

## 2. The three layers — muscle memory map

| Layer | Key concept | Your prefix |
|---|---|---|
| tmux | splits/sessions | `Ctrl-a` (custom — default is `Ctrl-b`) |
| Neovim | normal mode commands | `<leader>` = `space` (LazyVim default) |
| WezTerm | mostly invisible — just the window | rarely used directly |

## 3. Daily entry point: the `tm` function

From any project directory in fish, run:

```fish
tm
```

This attaches to a tmux session named after the current folder, or creates one if
it doesn't exist. Run it again from a different project directory → a
new/different session. This is your "open project" replacement for VSCode's
"Open Folder."

## 4. tmux essentials (prefix = `Ctrl-a`)

- `Ctrl-a |` → split pane vertically
- `Ctrl-a -` → split pane horizontally
- `Ctrl-h/j/k/l` → move between panes **and** nvim splits seamlessly
  (vim-tmux-navigator — no prefix needed)
- `Ctrl-a d` → detach (session keeps running in the background)
- `tm <name>` again later → reattach to that session
- `Ctrl-a r` → reload tmux config after editing `.tmux.conf`
- Sessions, layouts, and directories **come back after a restart** (tmux-continuum
  auto-saves and restores them). Old scrollback doesn't, and on Windows don't rely
  on it to relaunch programs such as `nvim`

## 5. Neovim / LazyVim essentials (leader = space)

- `space e` → toggle file explorer (VSCode sidebar equivalent)
- `space ff` → fuzzy find files (Cmd+P equivalent)
- `space sg` → grep across the whole project
- `space ,` or `space bb` → switch buffers
- `space bd` → close the current buffer (keeps the split open)
- `space bD` → close the current buffer and its split
- `space bo` → close every other buffer
- `:bd!` → force-close the current buffer without saving changes
- `[b` / `]b` → previous / next buffer
- `Ctrl-s` → save the current file
- `:q` → quit the current window
- `space -` / `space |` → split below / to the right
- `space wd` → close the current split
- `gd` → go to definition
- `K` → hover docs
- `space ca` → code actions
- `space cr` → rename symbol
- Format-on-save is already on (mirrors the VSCode Prettier setup)
- `space ft` → open a terminal in the project root (fish)
- `space aa` → toggle Copilot Chat (macOS only)
- `space aq` → quick one-off Copilot prompt (macOS only)
- `Alt-]` / `Alt-[` → cycle inline Copilot suggestions (macOS only)
- `:Lazy` → plugin manager UI
- `:Mason` → LSP/formatter installer UI
- `space gg` → open lazygit (full git UI, no CLI memorization needed)

## 6. Clipboard — just works

Yank (`y`) in nvim and paste in tmux or any other app with Cmd+V (macOS) or
Ctrl+V (Windows), and vice versa. Verified working end-to-end on both (nvim inside
tmux ↔ system clipboard).

## 7. How to actually migrate (gradual/parallel approach)

Pick **one small project** first. Do all edits in `tm` → nvim for a week. Keep
VSCode open for anything unfamiliar or where you hit friction. When something's
missing (a keybind, a linter, an LSP feature), fix the config — it's versioned in
this repo, so changes are easy to track and roll back — then progressively expand
to more projects.

## Reference: where things live in this repo

- `.wezterm.lua` — WezTerm config (theme, font, shell)
- `.tmux.conf` — tmux config (keybinds, plugins, clipboard, true color)
- `nvim/` — LazyVim config (`lua/config/lazy.lua` = language and Copilot extras,
  `lua/plugins/theme.lua` = Catppuccin, `lua/plugins/tmux-navigator.lua` = pane
  navigation)
- `fish/` — shell config, including the `tm` helper (`fish/functions/tm.fish`) and
  the prompt (`fish/functions/fish_prompt.fish`). Fisher installs everything listed
  in `fish/fish_plugins`
- Secrets (`secrets.fish`, `.secrets.env`, `fish_variables`) are intentionally
  **not** in this repo — see the "restore local-only secrets" step in the README.
