-- directory editiing as a buffer

return {
  {
    'stevearc/oil.nvim',
    config = function()

      require("oil").setup({
        default_file_explorer = false,
        columns = {},  -- columns to be viewed when you open directoy in oil
        constrain_cursor = "name",
        watch_for_changes = true,
        view_options = {
          show_hidden = true,
        },
        keymaps = {
          ["<BS>"] = { "actions.parent", mode = "n" },
          ["<C-v>"] = { "actions.select", opts = { vertical = true } },
          ["<C-d>"] = { "actions.preview_scroll_down", mode = "n"},
          ["<C-u>"] = { "actions.preview_scroll_up", mode = "n"},
          ["gd"] = {
            desc = "Toggle file detail view",
            callback = function()
              detail = not detail
              if detail then
                require("oil").set_columns({ "permissions", "size", "mtime" })
              else
                require("oil").set_columns({})
              end
            end,
          },
          ["<Esc>"] = { "actions.close" },
          ["<leader>e"] = { "actions.close" },
        },
        float = {
          padding = 2,
          max_width = 0.6,
          max_height = 0,
          border = "rounded",
          win_options = {
            number = true,
            winblend = 5,
          },
        },
        preview_win = {
          win_options = {
            winblend = 5,
          },
        },
        keymaps_help = {
          border = "rounded",
        },
        confirmation = {
          border = "rounded",
        }
      })

      vim.keymap.set(
        "n",
        "-",
        function()
          require("oil").open(nil, { preview = { vertical = true } })
        end,
        { desc = 'Open parent directory in oil.nvim' }
      )

      vim.keymap.set(
        "n",
        "<leader>e",
        function()
          require("oil").open_float(vim.fn.getcwd(), { preview = { vertical = true } })
        end,
        { desc = "Project directory in Oil with preview" }
      )

    end,
  },
}
