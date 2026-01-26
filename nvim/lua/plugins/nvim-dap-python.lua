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
        name = '(ipapi) ip.di_graphql.router',
        module = 'ip.di_graphql.router',
        cwd = '${workspaceFolder}/api',
        console = 'integratedTerminal',
      })
      table.insert(require('dap').configurations.python, {
        type = 'python',
        request = 'launch',
        name = '(ipapi) api/wsgi.py',
        module = 'wsgi',
        cwd = '${workspaceFolder}/api',
        console = 'integratedTerminal',
      })
      table.insert(require('dap').configurations.python, {
        type = 'python',
        request = 'launch',
        name = '(ipapi) api/images/main.py',
        module = 'images.main',
        cwd = '${workspaceFolder}/api',
        console = 'integratedTerminal',
      })
      table.insert(require('dap').configurations.python, {
        type = 'python',
        request = 'launch',
        name = '(ipapi) lookup/src/app.py',
        module = 'src.app',
        cwd = '${workspaceFolder}',
        console = 'integratedTerminal',
      })
      table.insert(require('dap').configurations.python, {
        type = 'python',
        request = 'launch',
        name = '(ipapi) lookup/src/feeder.py feed',
        module = 'src.feeder',
        args = {"feed"},
        cwd = '${workspaceFolder}',
        console = 'integratedTerminal',
      })
      table.insert(require('dap').configurations.python, {
        type = 'python',
        request = 'launch',
        name = '<ass-service>/src/app.py',
        module = 'src.app',
        cwd = '${workspaceFolder}',
        console = 'integratedTerminal',
        justMyCode = false,
      })
      table.insert(require('dap').configurations.python, {
        type = 'python',
        request = 'launch',
        name = '<nvgraph>/src/main.py',
        module = 'src.main',
        cwd = '${workspaceFolder}',
        console = 'integratedTerminal',
        justMyCode = false,
      })
      table.insert(require('dap').configurations.python, {
        type = 'python',
        request = 'launch',
        name = '<auth-api>/src/main.py',
        module = 'app.main',
        cwd = '${workspaceFolder}/backend/app',
        console = 'integratedTerminal',
        justMyCode = false,
      })

      vim.keymap.set("n", "<leader>dp", require("dap-python").test_method, { desc = "[P]ytest method under cursor" })

    end,
  },
}
