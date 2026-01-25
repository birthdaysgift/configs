return {
  {
    "lewis6991/hover.nvim",
    config = function()
      require('hover').config({
        providers = {
          'hover.providers.lsp',
          'hover.providers.diagnostic',
          'hover.providers.dap',
        },
        preview_opts = {
          border = 'rounded'
        },
        -- Whether the contents of a currently open hover window should be moved
        -- to a :h preview-window when pressing the hover keymap.
        preview_window = true,
        title = true,
        mouse_providers = {
          'hover.providers.lsp',
        }
      })

      vim.keymap.set('n', 'K', function()
        require('hover').open()
      end, { desc = 'hover.nvim (open)' })

      vim.keymap.set('n', 'gk', function()
        require('hover').enter()
      end, { desc = 'hover.nvim (enter)' })

    end
  }
}

