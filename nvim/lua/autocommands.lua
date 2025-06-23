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


--  This function gets run when an LSP attaches to a particular buffer.
--    That is to say, every time a new file is opened that is associated with
--    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
--    function will be executed to configure the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  callback = function(event)
    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    --    See `:help CursorHold` for information about when this is executed

    -- When you move your cursor, the highlights will be cleared (the second autocommand).
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client.server_capabilities.documentHighlightProvider then
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        callback = vim.lsp.buf.clear_references,
      })
    end

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

-- Filetypes for which autosave is enabled
local autosave_filetypes = {
  -- you can filetype of the current buffer via
  -- :lua print(vim.bo.filetype)
  gitignore = true,
  lua = true,
  markdown = true,
  python = true,
  text = true,
}

-- Create a unique autocommand group to avoid duplication
vim.api.nvim_create_augroup("AutoSaveOnChange", { clear = true })

-- Define the autosave autocommands
vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
  group = "AutoSaveOnChange",
  callback = function(args)
    local buf = args.buf
    local ft = vim.bo[buf].filetype

    -- Only autosave for allowed filetypes and modifiable, modified buffers
    if autosave_filetypes[ft] and vim.bo[buf].modifiable and vim.bo[buf].modified then
      vim.api.nvim_buf_call(buf, function()
        vim.cmd("silent update")
      end)
    end
  end,
})
