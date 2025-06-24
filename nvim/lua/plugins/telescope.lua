-- Fuzzy Finder for everything - files, lsp, etc.

utils = require('utils')


return {
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',  -- adds pretty icons, but requires special font.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function() return (vim.fn.executable 'make' == 1) end
      },
    },
    config = function()

      require('telescope').setup({
        defaults = {
          file_ignore_patterns = { "^.git/", },
          vimgrep_arguments = utils.list_concat(
            require("telescope.config").values.vimgrep_arguments, 
            {
              "--hidden",  -- include hidden (dot-prefixed) files, like .bashrc
              "--glob", "!**/.git/*", -- exclude .git/ directory files
            }
          ),
        },
        pickers = {
          find_files = {
            hidden = true,  -- include hidden (dot-prefixed) files, like .bashrc
          },
        },
      })

      -- Enable telescope extensions
      require('telescope').load_extension("fzf")

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

      vim.keymap.set("n", "<leader>sn", "<NOP>", { desc = "[S]earch .[n]otrack directory" })
      vim.keymap.set(
        "n",
        "<leader>snf",
        function()
          require("telescope.builtin").find_files({ no_ignore = true, search_dirs = { ".notrack" }, })
        end,
        { desc = '[S]earch .[n]otrack/ files' }
      )
      vim.keymap.set(
        "n",
        "<leader>sng",
        function()
          require("telescope.builtin").live_grep({ 
            additional_args = { "--no-ignore" },
            search_dirs = { ".notrack" }, 
          })
        end,
        { desc = '[S]earch .[n]otrack/ by [G]rep' }
      )

    end,
  },
}
