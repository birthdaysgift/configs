-- lazygit integration inside nvim

return {
  {
    "kdheepak/lazygit.nvim",

    lazy = false,

    cmd = { "LazyGit" },

    config = function()
      vim.keymap.set("n", "<leader>L", ":LazyGit<CR>", { desc= '[L]azyGit' } )
    end,
  },
}
