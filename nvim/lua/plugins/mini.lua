return {
  {
    "echasnovski/mini.comment",
    opts = {
      options = {
        ignore_blank_line = true,
      },
      -- Module mappings. Use `''` (empty string) to disable one.
      mappings = {
        -- Toggle comment (like `gcip` - comment inner paragraph) for both
        -- Normal and Visual modes
        comment = 'gj',

        -- Toggle comment on current line
        comment_line = 'gjj',

        -- Toggle comment on visual selection
        comment_visual = 'gj',

        -- Define 'comment' textobject (like `dgc` - delete whole comment block)
        -- Works also in Visual mode if mapping differs from `comment_visual`
        textobject = 'gj',
      },
    },
  },

  -- Collection of various small independent plugins/modules
  {
    "echasnovski/mini.nvim",
    config = function()

      require("mini.ai").setup({
        custom_textobjects = {
          [' '] = function()
            local line = vim.fn.getline('.')
            local col = vim.fn.col('.') - 1

            -- Find left space boundary
            local left = col
            while left > 0 and line:sub(left, left) ~= ' ' do
              left = left - 1
            end

            -- Find right space boundary
            local right = col + 1
            while right <= #line and line:sub(right, right) ~= ' ' do
              right = right + 1
            end

            return {
              from = { line = vim.fn.line('.'), col = left + 1 },
              to = { line = vim.fn.line('.'), col = right - 1 },
            }
          end,
        },
        n_lines = 500,
      })

      -- Make `db` behave exactly like `dib`
      vim.keymap.set('n', 'db', function()
        vim.api.nvim_feedkeys('d', 'n', false)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('ib', true, false, true), 'x', false)
      end, { noremap = true, silent = true })

      -- Make `yb` behave exactly like `yib`
      vim.keymap.set('n', 'yb', function()
        vim.api.nvim_feedkeys('y', 'n', false)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('ib', true, false, true), 'x', false)
      end, { noremap = true, silent = true })

      -- Make `cb` behave exactly like `cib`
      vim.keymap.set('n', 'cb', function()
        local keys = vim.api.nvim_replace_termcodes('cib', true, false, true)
        vim.api.nvim_feedkeys(keys, 'm', true)
      end, { noremap = true, silent = true })

      -- Make `vq` behave exactly like `viq`
      vim.keymap.set('n', 'vq', function()
        vim.api.nvim_feedkeys('v', 'n', false)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('iq', true, false, true), 'x', false)
      end, { noremap = true, silent = true })

      -- Make `vb` behave exactly like `vib`
      vim.keymap.set('n', 'vb', function()
        vim.api.nvim_feedkeys('v', 'n', false)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('ib', true, false, true), 'x', false)
      end, { noremap = true, silent = true })

      -- disable default 's' behavior to not conflict with mini.surround
      vim.keymap.set({'n', 'v'}, 's', '<Nop>')
      require("mini.surround").setup()

      require("mini.splitjoin").setup({
        split = {
          hooks_post = {
            require("mini.splitjoin").gen_hook.add_trailing_separator(),
          },
        },
        join  = {
          hooks_post = {
            require("mini.splitjoin").gen_hook.del_trailing_separator(),
          }
        },
      })
    end,
  },
}
