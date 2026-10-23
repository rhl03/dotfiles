-- Use Pyrefly's "default" type-checking preset in every Python file,
-- even when there is no pyrefly.toml or pyproject.toml.
vim.lsp.config("pyrefly", {
  init_options = {
    pyrefly = {
      typeCheckingMode = "default",
    },
  },
})
