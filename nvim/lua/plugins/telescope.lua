-- Fuzzy Finder (files, lsp, etc)

return {
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',  -- adds pretty icons, but requires special font.
      {
        -- If encountering errors, see telescope-fzf-native README for install instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
    config = function()
      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup({})

      -- Enable telescope extensions, if they are installed
      pcall(require('telescope').load_extension, 'fzf')

      vim.keymap.set("n", "<leader>s", "<NOP>", { desc = "[S]earch with Telescope" })
      vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[H]elp" })
      vim.keymap.set("n", "<leader>sk", require("telescope.builtin").keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set("n", "<leader>ss", require("telescope.builtin").builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = '[S]earch by [G]rep' } )
      vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set("n", "<leader>sj", require("telescope.builtin").jumplist, { desc = '[S]earch [J]umplist' })
      vim.keymap.set("n", "<leader>sr", require("telescope.builtin").resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set("n", "<leader><leader>", require("telescope.builtin").buffers, { desc = '[ ] Existing buffers' })
      vim.keymap.set("n", "<leader>/", require("telescope.builtin").current_buffer_fuzzy_find, { desc = '[/] Fuzzily search in current buffer' })

    end,
  },
}
