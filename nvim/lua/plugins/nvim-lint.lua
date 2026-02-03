return {
  {
    "mfussenegger/nvim-lint",
    config = function()

      local function find_in_parents(filename, start_path)
        local dir = vim.fn.fnamemodify(start_path, ":p:h")

        while dir ~= "/" do
          if vim.fn.isdirectory(dir) == 0 then
            return false
          end
          if vim.fn.filereadable(dir .. "/" .. filename) == 1 then
            return true
          end
          dir = vim.fn.fnamemodify(dir, ":h")
        end
        return false
      end

      local triggers = {
        ["ruff"] = {
          markers = { ".ruff.toml"},
          filetypes = { "python", },
        },
        ["mypy"] = {
          markers = { ".mypy.ini", },
          filetypes = { "python", },
        },
        ["shellcheck"] = {
          markers = {},
          filetypes = { "sh", },
        }
      }

      local function has_marker(markers)
        if #markers == 0 then
          return true
        end
        for _, marker in ipairs(markers) do
          if find_in_parents(marker, vim.api.nvim_buf_get_name(0)) then
            return true
          end
        end
        return false
      end

      local function has_filetype(filetypes)
        for _, filetype in ipairs(filetypes) do
          if vim.bo.filetype == filetype then
            return true
          end
        end
        return false
      end

      vim.api.nvim_create_autocmd(
        {
          "BufEnter",
          "BufWritePost",
        }, {
          callback = function()

            for linter, configuration in pairs(triggers) do

              if has_marker(configuration["markers"]) and has_filetype(configuration["filetypes"]) then
                require("lint").try_lint(linter, { ignore_errors = true })
              end
            end
          end,
        }
      )
    end,
  },
}
