-- Useful plugin to show you pending keybinds.

return {
  {
    'folke/which-key.nvim',

    event = 'VimEnter',

    opts = {
      delay = 500,
      icons = { mappings = false },
    },
  },
}
