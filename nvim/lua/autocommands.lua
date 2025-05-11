-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('trim_whitespaces', { clear = true }),
  desc = 'Trim trailing white spaces',
  -- pattern = 'bash,c,cpp,lua,java,go,php,javascript,make,python,rust,perl,sql,txt,markdown',
  pattern = '*',
  callback = function()
    vim.api.nvim_create_autocmd('BufWritePre', {
      pattern = '<buffer>',
      -- Trim trailing whitespaces
      callback = function()
        -- Save cursor position to restore later
        local curpos = vim.api.nvim_win_get_cursor(0)
        -- Search and replace trailing whitespaces
        vim.cmd [[keeppatterns %s/\s\+$//e]]
        vim.api.nvim_win_set_cursor(0, curpos)
      end,
    })
  end,
})


local function split(string, delimiter)
  local result = {}
  local from  = 1
  local delim_from, delim_to = string.find(string, delimiter, from)
  while delim_from do
    table.insert(result, string.sub(string, from , delim_from-1))
    from  = delim_to + 1
    delim_from, delim_to = string.find(string, delimiter, from )
  end
  table.insert(result, string.sub(string, from ))
  return result
end


vim.api.nvim_create_user_command(
  'C',
  function(opts)
    if not opts.args then
      return
    end

    local config_path = ".notrack/nvim/config.json"
    local f=io.open(config_path, "r")
    if f==nil then
      io.close(f)
      print("config_path not found")
      return
    end

    local config = vim.json.decode(f:read("*a"))

    local args = split(opts.args, ":")

    local arg = table.remove(args, 1)
    local command_to_execute = config["commands"][arg] or arg
    vim.cmd("cgetex system('" .. command_to_execute .. "')")

    for _, arg in pairs(args) do
      local command_to_execute = config["commands"][arg] or arg
      vim.cmd("caddex system('" .. command_to_execute .. "')")
    end

  end,
  { nargs = '*', desc = "Custom Q command" }
)

