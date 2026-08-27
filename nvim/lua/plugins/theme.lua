-- File explorer / VSCode-sidebar equivalent, and Catppuccin Mocha theme matching
-- VSCode/WezTerm for visual continuity.
return {
  { import = "lazyvim.plugins.extras.editor.snacks_explorer" },
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
