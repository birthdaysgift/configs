-- utility functions

local M = {}


function M.list_concat(t1, t2)
  local result = vim.deepcopy(t1)
  vim.list_extend(result, t2)
  return result
end

function M.cmd_float(cmd)
  local win = vim.api.nvim_get_current_win()

  -- If .relative is non-empty, it means the window is a floating one
  -- (because relative will be set to 'editor', 'win', or 'cursor' for floating windows).
  if vim.api.nvim_win_get_config(win).relative ~= "" then
    vim.api.nvim_win_close(win, true)
  end

  vim.cmd(cmd)
end

return M
