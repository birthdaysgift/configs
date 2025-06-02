-- directory editiing as a buffer

return {
  {
    'stevearc/oil.nvim',
    config = function()

      require("oil").setup({
        default_file_explorer = false,
        columns = {},  -- columns to be viewed when you open directoy in oil
        view_options = {
          show_hidden = true,
        }
      })

      vim.keymap.set("n", "-", ":Oil<CR>", { desc = 'Open parent directory in oil.nvim' })

    end,
  },
}
