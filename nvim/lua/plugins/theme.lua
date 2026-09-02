-- File explorer / VSCode-sidebar equivalent, and Catppuccin Mocha theme matching
-- VSCode/WezTerm for visual continuity.
-- (The snacks_explorer extra is imported in config/lazy.lua, ahead of `plugins`,
-- per LazyVim's import-order check.)
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      flavour = "mocha",
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
