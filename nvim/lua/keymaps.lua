-- list actually set keymaps
-- :map

-- disable search highlights
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Center cursor after half-page jumps
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- quickfix list navigation
vim.keymap.set("n", "<C-j>", ":cnext<CR>", { desc="[Q]uickfix next" })
vim.keymap.set("n", "<C-k>", ":cprev<CR>", { desc="[Q]uickfix prev" })

-- tab navigation
vim.keymap.set("n", "C-f", function() end, { desc="Tab navigation" })
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

