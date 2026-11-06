-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- MSYS2: make a bare `:terminal` open fish; `vim.o.shell` stays bash for background
-- commands (see config/options.lua). `:terminal <cmd>` still runs <cmd> as given.
if vim.env.MSYSTEM then
  vim.cmd([[cnoreabbrev <expr> terminal getcmdtype() ==# ':' && getcmdline() ==# 'terminal' ? 'terminal fish' : 'terminal']])
  vim.cmd([[cnoreabbrev <expr> term getcmdtype() ==# ':' && getcmdline() ==# 'term' ? 'terminal fish' : 'term']])
end
