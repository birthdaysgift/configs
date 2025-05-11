-- list actually set keymaps
-- :map

-- disable search highlights
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Center cursor after half-page jumps
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

