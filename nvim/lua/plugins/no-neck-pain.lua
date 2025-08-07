return {
  {
    "shortcuts/no-neck-pain.nvim",
    version = "*",
    config = function()
      require("no-neck-pain").setup({width=135})

      vim.keymap.set("n", "<leader>N", ":NoNeckPain<CR>", { desc = "Toggle [N]oNeckPain" })

      vim.api.nvim_create_autocmd({ "BufEnter" }, { callback = require("no-neck-pain").enable })
    end,
  }
}
