-- WezTerm configuration
-- https://wezfurlong.org/wezterm/config/files.html

local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Appearance: match the Catppuccin Mocha theme used in VSCode for visual continuity
config.color_scheme = "Catppuccin Mocha"

-- Font: JetBrains Mono Nerd Font (installed via `brew install --cask
-- font-jetbrains-mono-nerd-font`) so file/git icons render correctly in
-- nvim/tmux/lazygit.
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 14.0

-- True color / undercurl support (required for correct colors inside tmux + nvim)
config.term = "wezterm"
config.enable_kitty_graphics = true

-- Launch fish as the default shell inside WezTerm
config.default_prog = { "/opt/homebrew/bin/fish", "-l" }

-- Enable WezTerm's native shell integration escape sequences (fish supports this
-- out of the box) for things like "jump to previous prompt" and reporting the
-- current working directory to new panes/tabs.
config.window_decorations = "RESIZE"
config.window_close_confirmation = "NeverPrompt"

-- Slightly larger scrollback since tmux will also manage its own history per pane.
config.scrollback_lines = 10000

-- Tab bar tweaks
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false

return config
