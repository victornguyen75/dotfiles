# Terminal-Only Workflow: Onboarding Guide

WezTerm + tmux + Neovim (LazyVim), running alongside VSCode during a gradual,
project-by-project migration. fish stays the shell throughout.

## 1. First-time setup (do this once)

1. Merge the PR that introduced these configs (or pull `main` after it's merged) —
   your live machine already has everything symlinked, but this repo is the source
   of truth going forward for any new machine.
2. Set **WezTerm** as your default terminal app (Spotlight → set as default, or
   just launch it manually and pin it to the Dock).
3. Open WezTerm → it launches straight into fish. Run `nvim` once — plugins are
   already installed, but run `:LspCopilotSignIn` to authenticate Copilot
   (one-time GitHub device-flow login, same subscription as VSCode's Copilot Chat).

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
- Sessions **survive reboots** (tmux-continuum auto-saves/restores every session)

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
- `space aa` → toggle Copilot Chat
- `space aq` → quick one-off Copilot prompt
- `Alt-]` / `Alt-[` → cycle inline Copilot suggestions
- `:Lazy` → plugin manager UI
- `:Mason` → LSP/formatter installer UI
- `space gg` → open lazygit (full git UI, no CLI memorization needed)

## 6. Clipboard — just works

Yank (`y`) in nvim, paste in tmux or any macOS app with Cmd+V, and vice versa.
Verified working end-to-end (nvim inside tmux ↔ macOS system clipboard).

## 7. How to actually migrate (gradual/parallel approach)

Pick **one small project** first. Do all edits in `tm` → nvim for a week. Keep
VSCode open for anything unfamiliar or where you hit friction. When something's
missing (a keybind, a linter, an LSP feature), fix the config — it's versioned in
this repo, so changes are easy to track and roll back — then progressively expand
to more projects.

## Reference: where things live in this repo

- `.wezterm.lua` — WezTerm config (theme, font, shell)
- `.tmux.conf` — tmux config (keybinds, plugins, clipboard, true color)
- `nvim/` — LazyVim config (`lua/plugins/extras.lua` = language servers/formatters,
  `lua/plugins/ai.lua` = Copilot, `lua/plugins/theme.lua` = Catppuccin + file
  explorer)
- `fish/` — shell config, including the `tm` helper (`fish/functions/tm.fish`)
- Secrets (`secrets.fish`, `.secrets.env`, `fish_variables`) are intentionally
  **not** in this repo — see the README's "Secrets" section.
