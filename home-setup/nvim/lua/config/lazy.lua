local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazyrepo,
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    { import = "plugins" },

    {
      "GustavEikaas/easy-dotnet.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "mfussenegger/nvim-dap",
        "folke/snacks.nvim",
      },
      config = function()
        local dotnet = require("easy-dotnet")

        dotnet.setup({
          managed_terminal = {
            auto_hide = true,
            auto_hide_delay = 1000,
          },

          projx_lsp = {
            enabled = true,
          },

          lsp = {
            enabled = true,
            preload_roslyn = true,
            roslynator_enabled = true,
            easy_dotnet_analyzer_enabled = true,
            auto_refresh_codelens = true,
            suggest_updates = true,
            razor = {
              enabled = true,
              html = {
                enabled = true,
                request_timeout = 5000,
              },
            },
          },

          debugger = {
            engine = "netcoredbg",
            console = "integratedTerminal",
            auto_register_dap = true,
          },

          test_runner = {
            auto_start_testrunner = true,
            viewmode = "float",
          },

          picker = "snacks",

          diagnostics = {
            default_severity = "error",
          },
        })

        -- Commands / keymaps
        vim.api.nvim_create_user_command("Secrets", function()
          dotnet.secrets()
        end, {})

        vim.keymap.set("n", "<leader>db", ":Dotnet build<CR>")
        vim.keymap.set("n", "<leader>dr", ":Dotnet run<CR>")
        vim.keymap.set("n", "<leader>dt", ":Dotnet test<CR>")
        vim.keymap.set("n", "<C-p>", function()
          vim.cmd("Dotnet run profile default")
        end)
      end,
    },
  },

  defaults = {
    lazy = false,
    version = false,
  },

  install = {
    colorscheme = { "tokyonight", "habamax" },
  },

  checker = {
    enabled = true,
    notify = false,
  },

  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "zipPlugin",
      },
    },
  },
})
