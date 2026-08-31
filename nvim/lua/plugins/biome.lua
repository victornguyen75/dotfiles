-- Projects that ship a biome.json/biome.jsonc (e.g. graphql-mocker) use Biome
-- instead of Prettier/ESLint, mirroring their VSCode workspace settings
-- ("editor.defaultFormatter": "biomejs.biome", "prettier.enable": false).
--
-- The explicit `condition` below (requiring biome.json{,c} to exist) makes
-- this a no-op in repos that don't use Biome, so Prettier/ESLint (set up by
-- the formatting.prettier / linting.eslint extras) keep working there. This
-- guard is required because conform's bundled "biome" formatter falls back
-- to a bare `biome` on $PATH when node_modules/.bin/biome is absent, and
-- Mason installs `biome` globally for the LSP server below -- without the
-- condition, non-Biome repos would still get formatted with Biome's default
-- style (double quotes, semicolons).
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        biome = {},
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      for _, ft in ipairs({ "javascript", "javascriptreact", "typescript", "typescriptreact", "json", "jsonc" }) do
        local existing = opts.formatters_by_ft[ft] or {}
        local merged = { "biome" }
        for _, formatter in ipairs(existing) do
          table.insert(merged, formatter)
        end
        merged.stop_after_first = true -- use biome if available, else fall back (e.g. prettier)
        opts.formatters_by_ft[ft] = merged
      end

      -- Mason installs a `biome` CLI globally alongside the `biome` LSP
      -- server (see below), so conform's bundled "biome" formatter can
      -- resolve to that global binary via $PATH even in repos with no
      -- local node_modules/.bin/biome. Without this guard, projects that
      -- don't use Biome at all (no biome.json) would silently get
      -- formatted with Biome's default style (double quotes, semicolons)
      -- instead of falling back to Prettier/ESLint as intended.
      opts.formatters = opts.formatters or {}
      opts.formatters.biome = vim.tbl_deep_extend("force", opts.formatters.biome or {}, {
        condition = function(_, ctx)
          return vim.fs.find({ "biome.json", "biome.jsonc" }, { path = ctx.dirname, upward = true })[1] ~= nil
        end,
      })

      return opts
    end,
  },
}
