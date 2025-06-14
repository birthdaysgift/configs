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
        settings = {
          python = {
            analysis = {
              -- disable global typechecking in favor of per project typing configurations
              typeCheckingMode = "off"
            }
          }
        },
      })

      vim.keymap.set(
        "n",
        "gd",
        function()
          vim.lsp.buf.definition()

          -- since definition() is asynchronous,
          -- we need to wait some time (in milliseconds)
          -- for it finish execution
          vim.defer_fn(function()
            vim.cmd("normal! zz")
          end, 50)

        end,
        { desc = "Definition [LSP]" }
      )

    end,

  },
}
