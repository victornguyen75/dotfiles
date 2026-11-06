-- AI coding assistance parity with VSCode's GitHub Copilot Chat:
-- - `ai.copilot-native` gives inline "ghost text" suggestions via Neovim's built-in
--   LSP inline-completion support (copilot-language-server), requires Neovim >= 0.12.
-- - `ai.copilot-chat` gives a CopilotChat.nvim panel (<leader>aa to toggle,
--   <leader>aq for a quick one-off prompt) using the same GitHub Copilot
--   subscription/auth.
-- Extras are imported in config/lazy.lua (must precede `{ import = "plugins" }`
-- per LazyVim's import-order check), so nothing to add here currently.
--
-- CopilotChat.nvim is pinned here (not via lazy-lock.json) because the extra
-- that pulls it in is Mac-only (see config/lazy.lua): Windows never loads this
-- spec, so any `Lazy sync` run there drops CopilotChat.nvim from the shared
-- lockfile. An explicit `commit` in the spec is authoritative over the
-- lockfile for this plugin, so it stays pinned regardless of which OS last
-- synced. Bump deliberately when ready, not as a side effect of a sync.
--
-- `optional = true` matters here: this file is always imported via
-- `{ import = "plugins" }` (config/lazy.lua), with `defaults.lazy = false` for
-- custom plugins, regardless of the Windows `cond` on the copilot-chat extra.
-- Without `optional`, this fragment would stand alone as its own plugin spec on
-- Windows and eagerly install/load CopilotChat.nvim there too, defeating the
-- Windows exclusion. With `optional = true`, it only merges into (and pins) the
-- plugin when the Mac-only extra has already declared it.
return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    optional = true,
    commit = "f5171b9575279995205fde6a6c06c2632bb0b9d9",
  },
}
