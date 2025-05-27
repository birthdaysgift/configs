  -- prevent the cursor from moving when using shift and filter actions
  -- for some reason it breaks which-key tips for > and =
  -- but the plugin itself works fine

return {
  {
    'gbprod/stay-in-place.nvim',
    opts = {
      set_keymaps = true,
      preserve_visual_selection = true,
    }
  },
}

