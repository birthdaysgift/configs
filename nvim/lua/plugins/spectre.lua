return {
  {
    "nvim-pack/nvim-spectre",
    config = function()
      require('spectre').setup()
      vim.keymap.set('n', '<leader>S', require("spectre").toggle, {
          desc = "[S]pectre"
      })
    end
  }
}

