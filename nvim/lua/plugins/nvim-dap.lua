return {
  {
    "mfussenegger/nvim-dap",

    dependencies = {
      "mason-org/mason.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim"
    },

    config = function()
      require("mason").setup({})

      require("mason-tool-installer").setup({
        ensure_installed = {
          "debugpy",
        },
      })

      vim.keymap.set("n", "<leader>d", "<NOP>", { desc = "[D]ebug" })
      vim.keymap.set("n", "<leader>dl", require("dap").run_last, { desc = "Run [L]ast" })
      vim.keymap.set("n", "<leader>dc", require("dap").continue, { desc = "[C]ontinue" })
      vim.keymap.set("n", "<leader>dC", require("dap").run_to_cursor, { desc = "[C]ontinue to [C]ursor" })
      vim.keymap.set("n", "<leader>dk", require("dap").step_into, { desc = "Step into" })
      vim.keymap.set("n", "<leader>dj", require("dap").step_over, { desc = "Step over" })
      vim.keymap.set("n", "<leader>do", require("dap").step_out, { desc = "Step out" })
      vim.keymap.set("n", "<leader>dt", require("dap").terminate, { desc = "[T]erminate" })

      vim.keymap.set("n", "<leader>b", "<NOP>", { desc = "[B]reakpoints" })
      vim.keymap.set("n", "<leader>bb", require("dap").toggle_breakpoint, { desc = "[B]reakpoint" })
      vim.keymap.set(
        "n",
        "<leader>bc",
        function()
          require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: '))
        end,
        { desc = "[C]onditional breakpoint" }
      )
      vim.keymap.set(
        "n",
        "<leader>bl",
        function()
          require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
        end,
        { desc = "[L]ogpoint" }
      )

    end,
  },
}

