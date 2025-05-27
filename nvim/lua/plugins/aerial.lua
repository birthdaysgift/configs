return {
  {
    "stevearc/aerial.nvim",
    dependencies = { "neovim/nvim-lspconfig", },
    opts = {
      filter_kind = false,  -- display all symbols
      float = {
        relative = "editor",
      },
      nav = {
        preview = true,
        keymaps = {
          ["q"] = "actions.close",
        },
      },
    },
  },
}
