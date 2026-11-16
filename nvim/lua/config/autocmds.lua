-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- MSYS2 fallback only: ConPTY under tmux leaves stale cells behind, so force a
-- redraw at common trigger points. Not needed on macOS or WSL.
if vim.env.MSYSTEM then
  vim.api.nvim_create_autocmd({ "VimResized", "FocusGained", "CmdlineLeave" }, {
    callback = function()
      vim.cmd("redraw")
    end,
  })
end
