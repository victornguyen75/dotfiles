-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- MSYS2: nvim is a native Windows program, so it picks up SHELL=bash from the
-- pane but keeps cmd.exe's flags (/s /c), which breaks `:!` and system() calls
-- such as vim-tmux-navigator's. Use bash explicitly, with its own flags.
if vim.fn.has("win32") == 1 and vim.env.MSYSTEM then
  vim.o.shell = "bash"
  vim.o.shellcmdflag = "-c"
  vim.o.shellquote = ""
  vim.o.shellxquote = ""
end
