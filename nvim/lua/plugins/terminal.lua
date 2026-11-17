-- MSYS2: `vim.o.shell` is bash for background commands (see config/options.lua),
-- so point nvim's interactive terminals at fish. See config/keymaps.lua for :terminal.
return {
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      if vim.env.MSYSTEM then
        opts.terminal = vim.tbl_deep_extend("force", opts.terminal or {}, { shell = "fish" })
      end
    end,
  },
}
