-- list actually set keymaps
-- :map

-- disable search highlights
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Center cursor after jumps
vim.keymap.set('n', 'G', 'Gzz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-o>', '<C-o>zz')
vim.keymap.set('n', '<C-i>', '<C-i>zz')

-- quickfix list navigation
vim.keymap.set("n", "<Down>", ":cnext<CR>", { desc="[Q]uickfix next" })
vim.keymap.set("n", "<Up>", ":cprev<CR>", { desc="[Q]uickfix prev" })


vim.keymap.set("i", "<C-k>", function()
  return "<Esc>ddkA"
end, { noremap = true, expr = true })


vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")


-- tab navigation
vim.keymap.set("n", "<C-f>", function() end, { desc="Tab navigation" })
vim.keymap.set("n", "<C-f>1", "1gt", { desc="Tab 1" })
vim.keymap.set("n", "<C-f>2", "2gt", { desc="Tab 2" })
vim.keymap.set("n", "<C-f>3", "3gt", { desc="Tab 3" })
vim.keymap.set("n", "<C-f>4", "4gt", { desc="Tab 4" })
vim.keymap.set("n", "<C-f>5", "5gt", { desc="Tab 4" })
vim.keymap.set("n", "<C-f>6", "6gt", { desc="Tab 4" })
vim.keymap.set("n", "<C-f>7", "7gt", { desc="Tab 4" })
vim.keymap.set("n", "<C-f>8", "8gt", { desc="Tab 4" })
vim.keymap.set("n", "<C-f>9", "9gt", { desc="Tab 4" })
vim.keymap.set("n", "<C-f>n", ":tabnew<CR>", { desc="New tab" })
vim.keymap.set("n", "<C-f>x", ":tabclose<CR>", { desc="Close tab" })


local show_diagnostics = false
vim.keymap.set("n", "<leader>D", function()

  show_diagnostics = not show_diagnostics

  vim.diagnostic.config({
    virtual_lines = show_diagnostics and {
      format = function(diagnostic)
        -- Customize the format to include the source
        return string.format("[%s] %s", diagnostic.source, diagnostic.message)
      end,
    },
  })

end, { desc = "Toggle virtual lines for diagnostics" })
