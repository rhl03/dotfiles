return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      basedpyright = {
        enabled = false, -- replaced by pyrefly
      },
      pyrefly = {
        init_options = {
          pyrefly = {
            -- Use Pyrefly's standard preset, even without a pyrefly.toml or pyproject.toml.
            typeCheckingMode = "default",
          },
        },
      },
      ruff = {
        init_options = {
          settings = {
            lineLength = 88,
          },
        },
        on_attach = function(client)
          -- pyrefly owns hover; avoid duplicate popups
          client.server_capabilities.hoverProvider = false
        end,
      },
    },
  },
}
