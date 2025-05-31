-- LSP Configuration & Plugins

return {
  {
    "neovim/nvim-lspconfig",

    dependencies = {
      "mason-org/mason.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim"
    },

    config = function()
      require("mason").setup({})

      require("mason-tool-installer").setup({
        ensure_installed = {
          "pyright",
        },
      })

      require("lspconfig").pyright.setup({})
    end,

  },
}
