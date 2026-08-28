-- Projects that ship a biome.json/biome.jsonc (e.g. graphql-mocker) use Biome
-- instead of Prettier/ESLint, mirroring their VSCode workspace settings
-- ("editor.defaultFormatter": "biomejs.biome", "prettier.enable": false).
--
-- conform's bundled "biome" formatter only activates when it finds a
-- biome.json{,c} (via cwd = util.root_file(...)) and a `biome` binary in
-- node_modules, so this is a no-op in repos that don't use Biome and
-- Prettier/ESLint (set up by the formatting.prettier / linting.eslint
-- extras) keep working there.
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
      return opts
    end,
  },
}
