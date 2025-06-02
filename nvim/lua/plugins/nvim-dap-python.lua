return {
  {
    "mfussenegger/nvim-dap-python",
    ft = 'python',
    dependencies = {
      'mfussenegger/nvim-dap',
      'rcarriga/nvim-dap-ui',
    },
    config = function()
      require('dap-python').setup '~/.local/share/nvim/mason/packages/debugpy/venv/bin/python3'
      require('dap-python').test_runner = 'pytest'

      -- ... more options, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
      table.insert(require('dap').configurations.python, {
        type = 'python',
        request = 'launch',
        name = 'Current module',
        module = 'ip.di_graphql.router',
        cwd = '${workspaceFolder}/api',
        console = 'integratedTerminal',
      })

      vim.keymap.set("n", "<leader>dp", require("dap-python").test_method, { desc = "[P]ytest method under cursor" })

    end,
  },
}
