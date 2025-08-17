utils = require("utils")


return {
  {
    "kdheepak/lazygit.nvim",

    lazy = false,

    cmd = { "LazyGit" },

    config = function()
      vim.keymap.set("n", "<leader>L", function() utils.cmd_float("LazyGit") end, { desc= '[L]azyGit' })
    end,
  },
}
