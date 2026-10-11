return {
  "folke/persistence.nvim",
  opts = {},
  init = function()
    vim.api.nvim_create_autocmd("BufWritePost", {
      group = vim.api.nvim_create_augroup("PersistenceAutoSave", { clear = true }),
      callback = function()
        require("persistence").save()
      end,
    })
  end,
}
