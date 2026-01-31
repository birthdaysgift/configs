M = {}

local default_config = {
  ["venv"] = ".venv/bin/activate"
}


function M.load_config()
  local config = default_config
  local config_file = vim.fn.getcwd() .. "/.notrack/nvim/config.lua"
  if vim.uv.fs_stat(config_file) then
    local local_config = dofile(config_file)
    for key, value in pairs(local_config) do
      config[key] = value
    end
  end
  return config
end


return M
