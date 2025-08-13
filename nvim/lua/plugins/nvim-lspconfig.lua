-- LSP Configuration & Plugins

return {
  {
    "neovim/nvim-lspconfig",

    dependencies = {
      "mason-org/mason.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files ("ft" - stands for "filetype")
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },

    config = function()
      require("mason").setup({})

      require("mason-tool-installer").setup({
        ensure_installed = {
          "pyright",
          "lua-language-server",
          "css-variables-language-server",
          "css-lsp",
          "rust-analyzer",
        },
      })

      require("lspconfig").lua_ls.setup({})

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

      require("lspconfig").css_variables.setup({})
      require("lspconfig").cssls.setup({})

      require("lspconfig").rust_analyzer.setup({})

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
