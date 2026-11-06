-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- MSYS2: make a bare `:terminal` open fish; `vim.o.shell` stays bash for background
-- commands (see config/options.lua). `:terminal <cmd>` still runs <cmd> as given.
--
-- A plain `cnoreabbrev` would also fire on the space after "terminal"/"term", before
-- any arguments are typed, so `:terminal npm test` would still get rewritten to
-- `:terminal fish npm test` (fish then tries to run "npm" as a script). Instead,
-- rewrite only on <CR>, and only when the command line is the bare word with no
-- arguments, so commands with arguments are left untouched.
if vim.env.MSYSTEM then
  local function fish_terminal_cr()
    if vim.fn.getcmdtype() == ":" then
      local cmdline = vim.fn.getcmdline()
      if cmdline == "terminal" or cmdline == "term" then
        -- <C-u> only deletes from the cursor to the start of the line, so if the
        -- cursor isn't at the end (e.g. the user pressed <Left> before <CR>), any
        -- trailing text would survive and corrupt the rewritten command. Move to
        -- the end first with <C-e> so <C-u> always clears the whole line.
        return "<C-e><C-u>" .. cmdline .. " fish<CR>"
      end
    end
    return "<CR>"
  end
  vim.keymap.set("c", "<CR>", fish_terminal_cr, { expr = true })
end
