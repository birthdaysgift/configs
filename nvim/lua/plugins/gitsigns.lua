-- Adds git related signs to the gutter, as well as utilities for managing changes

return {
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 0,
        ignore_whitespace = true,
        virt_text_priority = 100,
        use_focus = true,
      },
    },
  },
}
