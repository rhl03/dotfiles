return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        cs = { "csharpier" },
        rust = { "rustfmt" },
        python = { "ruff_organize_imports", "ruff_format" },
        javascript = { "prettierd" },
        javascriptreact = { "prettierd" },
        typescript = { "prettierd" },
        typescriptreact = { "prettierd" },
      },
      formatters = {
        prettier = {
          command = "/home/roan/.npm-global/bin/prettier",
        },
      },
    },
  },
}
