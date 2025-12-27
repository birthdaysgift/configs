return {
  {
    "sindrets/diffview.nvim",
    config = function()
      require("diffview").setup({
        keymaps = {
          disable_defaults = true
        }
      })

      vim.keymap.set(
        "n",
        "<leader>v",
        function()
          vim.cmd("DiffviewOpen")
        end
      )
    end
  }
}
