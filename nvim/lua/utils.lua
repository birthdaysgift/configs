-- utility functions

local M = {}


function M.list_concat(t1, t2)
  local result = vim.deepcopy(t1)
  vim.list_extend(result, t2)
  return result
end

return M
