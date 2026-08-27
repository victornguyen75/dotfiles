-- Language/tooling extras for Victor's stack: TypeScript/JavaScript, JSON, YAML
-- (GitHub Actions schema support comes bundled with the yaml extra's
-- yaml-language-server schema store), and Docker/Docker Compose.
--
-- Also enables Prettier-based formatting + ESLint linting to mirror the
-- formatOnSave/formatOnPaste behavior configured in VSCode, so output stays
-- consistent regardless of which editor saves the file.
return {
  { import = "lazyvim.plugins.extras.lang.typescript" },
  { import = "lazyvim.plugins.extras.lang.json" },
  { import = "lazyvim.plugins.extras.lang.yaml" },
  { import = "lazyvim.plugins.extras.lang.docker" },
  { import = "lazyvim.plugins.extras.formatting.prettier" },
  { import = "lazyvim.plugins.extras.linting.eslint" },
}
