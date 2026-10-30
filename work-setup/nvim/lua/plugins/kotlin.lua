return {
  {
    "stevearc/oil.nvim",
    lazy = true,
    opts = {
      default_file_explorer = false,
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        kotlin_lsp = { enabled = false },
      },
    },
  },

  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        accept = {
          auto_brackets = {
            blocked_filetypes = { "kotlin" },
          },
        },
      },
    },
  },

  {
    "AlexandrosAlexiou/kotlin.nvim",
    ft = { "kotlin" },
    dependencies = {
      "mason.nvim",
      "mason-lspconfig.nvim",
      "oil.nvim",
      "trouble.nvim",
    },
    opts = {
      inlay_hints = { enabled = true },
      folding = { enabled = true },
    },
  },
}
