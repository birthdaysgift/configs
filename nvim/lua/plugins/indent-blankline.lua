-- adds indentation guides to Neovim
--
return {
  {
    "lukas-reineke/indent-blankline.nvim",
    tag = "v2.20.8",  -- Use v2
    event = "BufReadPost",
    config = function()
      vim.opt.list = true
      require("indent_blankline").setup {
        space_char_blankline = " ",
        show_current_context = true,
        show_current_context_start = true,
      }
    end,
  },
}
