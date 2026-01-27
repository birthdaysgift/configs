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


vim.keymap.set("n", "<leader>X", "<cmd>!chmod +x %<CR>", { silent = true })

-- quickfix list navigation
vim.keymap.set("n", "<Down>", ":cnext<CR>", { desc="[Q]uickfix next" })
vim.keymap.set("n", "<Up>", ":cprev<CR>", { desc="[Q]uickfix prev" })

-- join lines without moving cursor
vim.keymap.set("n", "J", "mzJ`z")

-- paste in visual mode without overriding copy register
vim.keymap.set("v", "p", "P")

vim.keymap.set("i", "<C-k>", function()
  return "<Esc>ddkA"
end, { noremap = true, expr = true })


vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("v", "V", "$o_o")

vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "[W]rite buffer" })
vim.keymap.set("n", "<leader>q", ":quitall!<CR>", { desc = "[Q]uit nvim" })


-- tab navigation
vim.keymap.set("n", "<C-f>", "<NOP>", { desc="Tab navigation" })
vim.keymap.set("n", "<C-f>1", "1gt", { desc="Tab 1" })
vim.keymap.set("n", "<C-f>2", "2gt", { desc="Tab 2" })
vim.keymap.set("n", "<C-f>3", "3gt", { desc="Tab 3" })
vim.keymap.set("n", "<C-f>4", "4gt", { desc="Tab 4" })
vim.keymap.set("n", "<C-f>5", "5gt", { desc="Tab 5" })
vim.keymap.set("n", "<C-f>6", "6gt", { desc="Tab 6" })
vim.keymap.set("n", "<C-f>7", "7gt", { desc="Tab 7" })
vim.keymap.set("n", "<C-f>8", "8gt", { desc="Tab 8" })
vim.keymap.set("n", "<C-f>9", "9gt", { desc="Tab 9" })
vim.keymap.set("n", "<C-f>a", "1gt", { desc="Tab 1 (short)" })
vim.keymap.set("n", "<C-f>s", "2gt", { desc="Tab 2 (short)" })
vim.keymap.set("n", "<C-f>d", "3gt", { desc="Tab 3 (short)" })
vim.keymap.set("n", "<C-f>f", "4gt", { desc="Tab 4 (short)" })
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
