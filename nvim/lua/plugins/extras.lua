-- Language/tooling extras for Victor's stack: TypeScript/JavaScript, JSON, YAML
-- (GitHub Actions schema support comes bundled with the yaml extra's
-- yaml-language-server schema store), and Docker/Docker Compose.
--
-- Also enables Prettier-based formatting + ESLint linting to mirror the
-- formatOnSave/formatOnPaste behavior configured in VSCode, so output stays
-- consistent regardless of which editor saves the file.
-- Extras are imported in config/lazy.lua (must precede `{ import = "plugins" }`
-- per LazyVim's import-order check), so nothing to add here currently.
return {}
