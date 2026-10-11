return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      dim_inactive = true,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd("colorscheme tokyonight")
    end,
  },
  {
    "zaldih/themery.nvim",
    lazy = false,
    opts = {
      themes = {
        { name = "Tokyo Night", colorscheme = "tokyonight" },
        { name = "Tokyo Night Storm", colorscheme = "tokyonight-storm" },
        { name = "Tokyo Night Moon", colorscheme = "tokyonight-moon" },
        { name = "Tokyo Night Day", colorscheme = "tokyonight-day" },
      },
      livePreview = true,
    },
    keys = {
      { "<leader>tt", "<cmd>Themery<cr>", desc = "Theme picker" },
    },
  },
}
