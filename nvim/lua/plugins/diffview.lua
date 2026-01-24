return {
  {
    "sindrets/diffview.nvim",
    config = function()
      require("diffview").setup({
        keymaps = {
          disable_defaults = false
        }
      })

      local diffview_opened = false
      local function diffview_toggle()
          if not diffview_opened then
            vim.cmd("DiffviewOpen")
            diffview_opened = true
          else
            vim.cmd("DiffviewClose")
            diffview_opened = false
          end
      end

      vim.keymap.set("n", "<leader>v", diffview_toggle, { desc = "Diff [V]iew Toggle"})
    end
  }
}
