return {
  {
    "cbochs/grapple.nvim",
    dependencies = {
      { "nvim-tree/nvim-web-devicons", lazy = true }
    },
    config = function()
      require("grapple").setup()

      vim.keymap.set("n", "<leader>M", require("grapple").toggle, { desc = "Grapple toggle"})
      vim.keymap.set("n", "<leader>m", "<Nop>", { desc = "Grapple select" })

      vim.keymap.set("n", "<leader>mm", require("grapple").toggle_tags)
      vim.keymap.set("n", "<leader>ma", "<cmd>Grapple select index=1<cr>")
      vim.keymap.set("n", "<leader>ms", "<cmd>Grapple select index=2<cr>")
      vim.keymap.set("n", "<leader>md", "<cmd>Grapple select index=3<cr>")
      vim.keymap.set("n", "<leader>mf", "<cmd>Grapple select index=4<cr>")

    end
  }
}
