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
      require("mini.surround").setup()

      local statusline = require("mini.statusline")
      statusline.setup()
      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      statusline.section_location = function()
        return '%2l:%-2v %p%%'
      end

    end,
  },
}
