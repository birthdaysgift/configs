-- list actually set keymaps
-- :map

-- disable search highlights
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Center cursor after half-page jumps
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- toggle file-explorer
-- vim.keymap.set('n', '<leader>n', ':NvimTreeToggle<CR>', { desc = '[N]vimTree' })
vim.keymap.set('n', '<leader>n', ':Neotree position=float toggle=true<CR>', { desc = '[N]eotree' })
vim.keymap.set('n', '<leader>bn', ':Neotree buffers position=float toggle=true<CR>', { desc = '[B]uffers list' })

-- toggle oil.nvim
vim.keymap.set('n', '-', ':Oil<CR>', { desc = 'Open parent directory in oil.nvim' })

-- toggle nvim-blame-line
vim.keymap.set('n', '<leader>tb', ':ToggleBlameLine<CR>', { desc = '[B]lame' })

-- toggle LazyGit
vim.keymap.set('n', '<leader>l', ':LazyGit<CR>', { desc = '[L]azyGit' })

-- toggle nvim-precognition
vim.keymap.set('n', '<leader>p', ':Precognition toggle<CR>', { desc = '[P]recognition' })

-- open messages history
vim.keymap.set('n', '<leader>h', function()
  require('noice').cmd 'history'
end, { desc = 'Show notifications [H]istory' })
