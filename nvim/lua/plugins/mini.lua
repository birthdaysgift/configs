return {
  {
    "echasnovski/mini.comment",
    opts = {
      options = {
        ignore_blank_line = true,
      },
    },
  },

  -- Collection of various small independent plugins/modules
  {
    "echasnovski/mini.nvim",
    config = function()
      require("mini.ai").setup({ n_lines = 500 })

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
