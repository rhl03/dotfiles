-- Show Pyrefly type errors in every Python file,
-- even when there is no pyrefly.toml or pyproject.toml.
vim.lsp.config("pyrefly", {
  settings = {
    python = {
      pyrefly = {
        displayTypeErrors = "force-on",
      },
    },
  },
})
