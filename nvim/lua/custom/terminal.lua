config = require("custom.config")


local function get_available_windows()
  local windows = vim.api.nvim_list_wins()
  local non_terminal_windows = {}

  for _, win in ipairs(windows) do
    local bufnr = vim.api.nvim_win_get_buf(win)
    local buftype = vim.bo[bufnr].buftype

    if buftype ~= 'terminal' then
      table.insert(non_terminal_windows, win)
    end
  end

  return non_terminal_windows
end


local function open_file_in_window(win_id, file_path, row, col)
  -- Add the file to the buffer list (without switching windows)
  vim.cmd('badd ' .. file_path)

  -- get the buffer ID that was just added
  -- buffer ID is the most recently added buffer, so we can fetch it directly
  local buf_id = vim.fn.bufnr(file_path)

  -- if the buffer is found, set it in the specified window
  if buf_id ~= -1 then
    vim.api.nvim_win_set_buf(win_id, buf_id)
  end

  vim.api.nvim_win_set_cursor(win_id, {row, col})
  vim.api.nvim_set_current_win(win_id)
end


local function get_file_path()
  local current_line = vim.api.nvim_get_current_line()
  local _, _, filepath, row, col = string.find(current_line, "%s*([a-zA-Z/.]+):([0-9]*):([0-9]*)")
  if row == "" then
    row = 1
  end
  if col == "" then
    col = 1
  end
  return filepath, tonumber(row), tonumber(col) - 1
end


local function activate_venv()
  if (
    vim.bo.buftype ~= "terminal"
    or vim.bo.filetype == "TelescopePrompt"
    or vim.bo.filetype == "lazygit"
    or vim.bo.filetype == "dapui_console"
  ) then
    return
  end
  local config = config.load_config()
  local term_channel = vim.bo.channel
  if vim.uv.fs_stat(config["venv"]) then
    -- send the command to the terminal
    vim.api.nvim_chan_send(term_channel, "source " .. config["venv"] .. "\n")
  end
  print("filetype: " .. vim.bo.filetype)
  print("buftype: " .. vim.bo.buftype)
  vim.api.nvim_input("i")
end




local function toggle_term()
  if (
    vim.bo.buftype == 'terminal'
    and vim.bo.filetype ~= "lazygit"
    and vim.bo.filetype ~= "dapui_console"
  ) then
    vim.api.nvim_win_hide(0)
    return
  end

  -- Try to find an existing terminal buffer
  local term_buf
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if (
      vim.api.nvim_buf_is_loaded(buf)
      and vim.bo[buf].buftype == 'terminal'
      and vim.fn.bufwinnr(buf) ~= -1
    ) then
      -- terminal is visible in some window
      vim.cmd(vim.fn.bufwinnr(buf) .. 'wincmd w')
      return
    elseif (
      vim.api.nvim_buf_is_loaded(buf)
      and vim.bo[buf].buftype == 'terminal'
    ) then
      -- hidden terminal found
      term_buf = buf
    end
  end

  if term_buf then
    -- open existing terminal in a split
    vim.cmd('botright split')
    vim.cmd('buffer ' .. term_buf)
  else
    -- Open the terminal in a split (botright to place at the bottom)
    vim.cmd('botright split term://$SHELL')
    activate_venv()
  end
  vim.cmd('resize 15')
end


local function go_to_file()
  if vim.bo.buftype ~= 'terminal' then
    return
  end
  local file_path, row, col = get_file_path()
  if not file_path or vim.uv.fs_stat(file_path) then
    return
  end
  local win_id = get_available_windows()[1]
  open_file_in_window(win_id, file_path, row, col)
end


local function exit_term_mode()
  if (
    vim.bo.filetype ~= "lazygit"
    and vim.bo.filetype ~= "dapui_console"
  ) then
    vim.api.nvim_input([[<C-\><C-n>]])
  end
end


local function start_window_command()
  if (
    vim.bo.filetype ~= "lazygit"
    and vim.bo.filetype ~= "dapui_console"
  ) then
    vim.api.nvim_input([[<C-\><C-n><C-w>]])
  end
end


vim.keymap.set("n", "<CR>", go_to_file)
vim.keymap.set({"n", "v"}, '<C-k>', toggle_term)
vim.keymap.set("t", "<C-k>", exit_term_mode)
vim.keymap.set('t', '<C-w>', start_window_command)
