-- Save
vim.keymap.set("n", "<C-s>", "<cmd>w<cr>", { desc = "Save File" })
vim.keymap.set("i", "<C-s>", "<Esc><cmd>w<cr>", { desc = "Save File" })
vim.keymap.set("i", "<C-c>", "<Esc><cmd>w<cr>", { desc = "Save and Normal Mode" })

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })

-- Window resizing: the border moves in the direction of the key
local function resize(dir)
  local has_right = vim.fn.winnr("l") ~= vim.fn.winnr()
  local has_below = vim.fn.winnr("j") ~= vim.fn.winnr()
  if dir == "h" then
    vim.cmd("vertical resize " .. (has_right and "-5" or "+5"))
  elseif dir == "l" then
    vim.cmd("vertical resize " .. (has_right and "+5" or "-5"))
  elseif dir == "k" then
    vim.cmd("resize " .. (has_below and "-3" or "+3"))
  elseif dir == "j" then
    vim.cmd("resize " .. (has_below and "+3" or "-3"))
  end
end

vim.keymap.set({ "n", "t" }, "<A-H>", function()
  resize("h")
end, { desc = "Move border left" })
vim.keymap.set({ "n", "t" }, "<A-L>", function()
  resize("l")
end, { desc = "Move border right" })
vim.keymap.set({ "n", "t" }, "<A-J>", function()
  resize("j")
end, { desc = "Move border down" })
vim.keymap.set({ "n", "t" }, "<A-K>", function()
  resize("k")
end, { desc = "Move border up" })

-- Terminal
-- Every shell started from Neovim inherits this: bar cursor at each prompt
vim.env.PROMPT_COMMAND = "printf '\\e[6 q'"

-- Every terminal opens ready to type, whether via :terminal or <leader>tv
vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.cmd("startinsert")
  end,
})

-- Typing :terminal or :term on its own opens it in a vertical split
for _, word in ipairs({ "terminal", "term" }) do
  vim.keymap.set("ca", word, function()
    if vim.fn.getcmdtype() == ":" and vim.fn.getcmdline() == word then
      return "vsplit | terminal"
    end
    return word
  end, { expr = true })
end

vim.keymap.set("n", "<leader>tv", "<cmd>vsplit | terminal<cr>", { desc = "Terminal (vertical split)" })
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Move to left window" })
vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Move to right window" })
vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Move to lower window" })
vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Move to upper window" })

-- Clear search highlight
vim.keymap.set("n", "<Esc>", ":noh<cr>", { desc = "Clear search highlight" })

-- Custom commands
vim.api.nvim_create_user_command("Home", function()
  vim.cmd("silent! %bd!")
  Snacks.dashboard()
end, {})

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.py",
  callback = function()
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    for _, client in ipairs(clients) do
      client:stop()
    end
    vim.defer_fn(function()
      vim.cmd("edit")
    end, 100)
  end,
})

vim.keymap.del("n", "<leader>K")
