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

config.enable_kitty_graphics = true

-- Launch fish as the default shell inside WezTerm
if wezterm.target_triple:find('windows') then
  -- Prefer WSL (Ubuntu): tmux and Linux nvim talk VT directly. Under MSYS2,
  -- native nvim.exe sits behind a second ConPTY inside tmux, which tears the
  -- screen and leaks mouse escape sequences as stray "M" keystrokes.
  local msys2_fish = {
    'C:\\msys64\\msys2_shell.cmd', '-defterm', '-here', '-no-start', '-ucrt64', '-shell', 'fish'
  }
  local wsl_domains = wezterm.default_wsl_domains()
  local has_ubuntu = false
  for _, dom in ipairs(wsl_domains) do
    if dom.name == 'WSL:Ubuntu' then
      dom.default_cwd = '~'
      has_ubuntu = true
    end
  end
  config.wsl_domains = wsl_domains

  if has_ubuntu then
    config.default_domain = 'WSL:Ubuntu'
    -- Keep MSYS2 as a fallback: Ctrl+Alt+L opens the launcher to start it in a new tab.
    config.launch_menu = {
      { label = 'MSYS2 fish (fallback)', args = msys2_fish, domain = { DomainName = 'local' } },
    }
    config.keys = {
      { key = 'l', mods = 'CTRL|ALT', action = wezterm.action.ShowLauncherArgs({ flags = 'LAUNCH_MENU_ITEMS' }) },
    }
  else
    -- WSL not installed yet: keep the old MSYS2 behavior so nothing breaks.
    config.default_prog = msys2_fish
  end
elseif wezterm.target_triple:find('darwin') then
  -- True color / undercurl via WezTerm's own terminfo. Not set on Windows: there
  -- tmux talks to ConPTY (or WSL sets xterm-256color), not to WezTerm directly.
  config.term = "wezterm"
  config.default_prog = { "/opt/homebrew/bin/fish", "-l" }
end

-- Enable WezTerm's native shell integration escape sequences (fish supports this
-- out of the box) for things like "jump to previous prompt" and reporting the
-- current working directory to new panes/tabs.
config.window_decorations = "RESIZE"
config.window_close_confirmation = "NeverPrompt"

-- Default window size (in terminal cells, not pixels)
config.initial_cols = 240
config.initial_rows = 60

-- Set background opacity (0.0 is fully transparent, 1.0 is fully opaque)
config.window_background_opacity = 0.85

-- Resize the window to a percentage of the active screen's resolution on
-- startup, and center it. This keeps window sizing consistent across
-- different monitors/resolutions rather than relying on a fixed cell count.
wezterm.on("gui-startup", function(cmd)
	local screen = wezterm.gui.screens().active
	local width_frac, height_frac = 0.9, 0.9
	local width = screen.width * width_frac
	local height = screen.height * height_frac

	local _, _, window = wezterm.mux.spawn_window(cmd or {})
	local gui_window = window:gui_window()
	gui_window:set_inner_size(width, height)
	gui_window:set_position(screen.x + (screen.width - width) / 2, screen.y + (screen.height - height) / 2)
end)

-- Slightly larger scrollback since tmux will also manage its own history per pane.
config.scrollback_lines = 10000

-- Tab bar tweaks
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false

return config
