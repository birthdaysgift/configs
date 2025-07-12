return {
  {
    "jiaoshijie/undotree",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()

      require("undotree").setup({
        float_diff = false,
        position = "bottom",
      })

      vim.keymap.set("n", "<leader>U", require('undotree').toggle, { desc= '[U]ndotree' } )
    end,
  }
}
