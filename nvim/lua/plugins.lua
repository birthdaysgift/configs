-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field

vim.opt.rtp:prepend(lazypath)


local plugins = {}

local plugin_files = vim.fn.globpath(vim.fn.stdpath("config") .. "/lua/plugins", "*.lua", false, true)

for _, file in ipairs(plugin_files) do
  local module = file:match("lua/(.+)%.lua$")
  if module then
    local ok, plugin_list = pcall(require, module)
    if ok and type(plugin_list) == "table" then
      vim.list_extend(plugins, plugin_list)
    end
  end
end


require('lazy').setup(plugins)
