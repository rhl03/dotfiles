return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      dashboard = {
        preset = {
          header = [[
          ███╗   ██╗██╗   ██╗██╗███╗   ███╗
          ████╗  ██║██║   ██║██║████╗ ████║
          ██╔██╗ ██║██║   ██║██║██╔████╔██║
          ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║
          ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║
          ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝]],
          keys = {
            {
              icon = "",
              key = "f",
              desc = "Find File",
              action = ":lua Snacks.picker.files({ cwd = vim.env.HOME })",
            },
            {
              icon = "󰉋",
              key = "p",
              desc = "Projects",
              action = ":lua Snacks.picker.projects({ confirm = function(picker, item) picker:close() if item then vim.fn.chdir(item.file) vim.cmd('clearjumps') require('persistence').load() end end })",
            },
            {
              icon = "",
              key = "c",
              desc = "Config",
              action = ":lua Snacks.picker.files({ cwd = vim.fn.stdpath('config') })",
            },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = "󰗼", key = "q", desc = "Quit", action = ":qa" },
          },
        },
        sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = 1 },
        },
      },
      explorer = { enabled = true },
      picker = {
        enabled = true,
        sources = {
          projects = {
            display = "full",
          },
          explorer = {
            hidden = true,
          },
        },
      },
      notifier = {
        enabled = true,
        timeout = 5000,
        style = "fancy",
        top_down = true,
      },
    },
    keys = {
      {
        "<space><space>",
        function()
          Snacks.picker.files()
        end,
      },
      {
        "<leader>e",
        function()
          Snacks.explorer()
        end,
        desc = "File Explorer",
      },
    },
  },
}
