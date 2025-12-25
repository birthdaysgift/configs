vim.api.nvim_set_hl(0, "SnacksDim", { link = "Comment" })

return {
  {
    "folke/snacks.nvim",
    config = function()
      require("snacks").setup({
        zen = {
          toggles = { dim = false },
          win = { enter = true, backdrop = 10, width = 128 },
        },
        dim = {
          scope = {
            min_size = 1,
            max_size = 20,
            siblings = false,
          },
          animate = { enabled = false },
        }
      })

      local dimmed = false
      vim.keymap.set(
        "n",
        "<leader>F",
        function()
          dimmed = not dimmed
          if dimmed then
            require("snacks").dim.enable()
          else
            require("snacks").dim.disable()
          end
        end,
        { desc = "[D]im toggle" }
      )

      vim.keymap.set("n", "<leader>f", require("snacks").zen.zen, { desc = "[F]ocus mode" })
    end
  }
}


