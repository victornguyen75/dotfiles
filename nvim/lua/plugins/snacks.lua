return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        -- Top-level hidden/ignored only take effect for sources that don't
        -- define their own default (e.g. grep/live_grep via <leader>sg).
        -- `files` and `explorer` each set explicit hidden=false/ignored=false
        -- defaults, and those are merged in *after* this top-level config,
        -- so they silently win unless overridden per-source below.
        hidden = true, -- show hidden files (sources without their own default, e.g. grep)
        ignored = true, -- show gitignored files (sources without their own default, e.g. grep)
        sources = {
          explorer = {
            hidden = true, -- show hidden files in the file explorer
            ignored = true, -- show gitignored files in the file explorer
            exclude = { "**/node_modules" }, -- but still hide node_modules
          },
          files = {
            hidden = true, -- show hidden files in the fuzzy finder (<leader>ff)
            ignored = true, -- show gitignored files in the fuzzy finder
            exclude = { "**/node_modules" }, -- but still hide node_modules
          },
        },
      },
    },
  },
}
