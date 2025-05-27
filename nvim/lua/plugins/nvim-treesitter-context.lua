-- enables sticky context on scroll (same as "sticky scroll" feature in VSCode)

return {
  {
    'nvim-treesitter/nvim-treesitter-context',
    opts = {
      mode = 'topline',
      multiline_threshold = 1,
    },
  },
}
