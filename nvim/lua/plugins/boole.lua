return {
  {
    "nat-418/boole.nvim",
    config = function()
      require('boole').setup({
        mappings = {},
        additions = {
          {'Foo', 'Bar'},
        },
        allow_caps_additions = {
          {'enable', 'disable'}
        }
      })
      vim.keymap.set("n", "<C-a>", ":Boole increment<CR>")
      vim.keymap.set("n", "<C-x>", ":Boole decrement<CR>")
    end
  }
}

