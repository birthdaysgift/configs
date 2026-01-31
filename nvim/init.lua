-- https://learnxinyminutes.com/docs/lua/
-- :help lua-guide

-- Set <space> as the leader key
-- Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require 'autocommands'
require 'keymaps'
require 'opts'
require 'plugins'

require 'custom'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
