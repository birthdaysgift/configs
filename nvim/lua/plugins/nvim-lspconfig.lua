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

      require("lspconfig").pyright.setup({
        on_attach = function(client, bufnr)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Definition [LSP]"})
        end
      })
    end,

  },
}
