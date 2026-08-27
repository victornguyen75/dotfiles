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

-- Default window size (in terminal cells, not pixels)
config.initial_cols = 240
config.initial_rows = 60

-- Resize the window to a percentage of the active screen's resolution on
-- startup, and center it. This keeps window sizing consistent across
-- different monitors/resolutions rather than relying on a fixed cell count.
wezterm.on("gui-startup", function(cmd)
  local screen = wezterm.gui.screens().active
  local width_frac, height_frac = 0.8, 0.8
  local width = screen.width * width_frac
  local height = screen.height * height_frac

  local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
  local gui_window = window:gui_window()
  gui_window:set_inner_size(width, height)
  gui_window:set_position(
    screen.x + (screen.width - width) / 2,
    screen.y + (screen.height - height) / 2
  )
end)

-- Slightly larger scrollback since tmux will also manage its own history per pane.
config.scrollback_lines = 10000

-- Tab bar tweaks
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false

return config
