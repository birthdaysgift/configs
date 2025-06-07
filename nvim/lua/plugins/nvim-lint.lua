return {
  {
    "mfussenegger/nvim-lint",
    config = function()

      require("lint").linters_by_ft = {
        python = {"ruff", "flake8", "mypy"}
      }

      vim.api.nvim_create_autocmd(
        {
          "BufEnter",
          "BufWritePost",
        }, {
          callback = function()
            require("lint").try_lint(nil, { ignore_errors = true })
          end,
        }
      )

    end,
  },
}
