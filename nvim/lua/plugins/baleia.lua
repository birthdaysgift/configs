return {
  {
    "m00qek/baleia.nvim",
    version = "main",
    config = function()
      vim.g.baleia = require("baleia").setup({ colors = "NR8" })

      local function trim_trailing_empty_lines(buf)
        local last = vim.api.nvim_buf_line_count(buf)

        while last > 0 do
          local line = vim.api.nvim_buf_get_lines(buf, last - 1, last, false)[1]
          if line:match("^%s*$") then
            last = last - 1
          else
            break
          end
        end

        vim.api.nvim_buf_set_lines(buf, last, -1, false, {})
      end

      vim.api.nvim_create_autocmd('VimEnter', {
        group = vim.api.nvim_create_augroup('highlight_ansi', { clear = true }),
        desc = 'Enable ANSI codes highlighting.',
        pattern = '*tmux-scrollback',
        callback = function()
          local buf = vim.api.nvim_get_current_buf()
          trim_trailing_empty_lines(buf)
          vim.g.baleia.once(buf)
          vim.api.nvim_input("Gzb")
          vim.api.nvim_set_option_value("colorcolumn", "", { scope = "local",})
          vim.api.nvim_set_option_value("wrap", false, {scope = "local"})
          vim.api.nvim_set_option_value("number", false, {scope = "local"})
          vim.api.nvim_set_option_value("signcolumn", "no", {scope = "local"})
        end,
      })

    end,
  }
}
