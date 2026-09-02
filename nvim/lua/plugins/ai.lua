-- AI coding assistance parity with VSCode's GitHub Copilot Chat:
-- - `ai.copilot-native` gives inline "ghost text" suggestions via Neovim's built-in
--   LSP inline-completion support (copilot-language-server), requires Neovim >= 0.12.
-- - `ai.copilot-chat` gives a CopilotChat.nvim panel (<leader>aa to toggle,
--   <leader>aq for a quick one-off prompt) using the same GitHub Copilot
--   subscription/auth.
-- Extras are imported in config/lazy.lua (must precede `{ import = "plugins" }`
-- per LazyVim's import-order check), so nothing to add here currently.
return {}
