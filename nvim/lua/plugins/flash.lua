return {
  {
    "folke/flash.nvim",
    config = function()
      require("flash").setup({
        modes = {
          char = {
            enabled = false,
          },
        },
        prompt = { enabled = false },
        jump = {
          autojump = true,
          pos = "end",
        }
      })

      vim.api.nvim_set_hl(0, "FlashBackdrop", { link = "Comment" })
      vim.api.nvim_set_hl(0, "FlashMatch", { link = "Comment" })
      vim.api.nvim_set_hl(0, "FlashCurrent", { link = "Normal" })
      vim.api.nvim_set_hl(0, "FlashLabel", { link = "WarningMsg" })
      vim.api.nvim_set_hl(0, "FlashCursor", { link = "Comment" })

      vim.keymap.set({ "n", "x", "o" }, "R", require("flash").treesitter)
      vim.keymap.set({ "o" }, "r", require("flash").remote)
      vim.keymap.set({ "n", "x", "o" }, "S", require("flash").treesitter_search)
      vim.keymap.set({ "n", "x", "o" }, "L", require("flash").jump)

    end,
  }
}
