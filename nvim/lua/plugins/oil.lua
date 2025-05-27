-- directory editiing as a buffer

return {
  {
    'stevearc/oil.nvim',
    opts = {
      default_file_explorer = false,
      columns = {},  -- columns to be viewed when you open directoy in oil
      view_options = {
        show_hidden = true,
      }
    },
  },
}
