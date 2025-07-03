return {
  {
    "rcarriga/nvim-dap-ui",

    dependencies = {
      'mfussenegger/nvim-dap',
      'nvim-neotest/nvim-nio',
      {
        -- The telescope-ui-select extension allows Telescope to replace
        -- the default vim.ui.select() dialog with a Telescope-powered dropdown.

        -- This is useful when nvim-dap-ui uses vim.ui.select()
        -- to ask you to pick a debug configuration.
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
          require("telescope").setup({
            extensions = {
              ["ui-select"] = {
                require("telescope.themes").get_dropdown({})
              }
            },
          })
          require("telescope").load_extension("ui-select")
        end
      },
    },

    config = function()
      require('dapui').setup({
        controls = {
          element = "console",
          enabled = true,
          icons = {
            disconnect = "",
            pause = "",
            play = "",
            run_last = "",
            step_back = "",
            step_into = "",
            step_out = "",
            step_over = "",
            terminate = ""
          }
        },
        element_mappings = {},
        expand_lines = true,
        floating = {
          border = "single",
          mappings = {
            close = { "q", "<Esc>" }
          }
        },
        force_buffers = true,
        icons = {
          collapsed = "",
          current_frame = "",
          expanded = ""
        },

        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.8 },
              -- { id = "breakpoints", size = 0.25 },
              -- { id = "stacks", size = 0.25 },
              { id = "watches", size = 0.2 },
            },
            position = "left",
            size = 40
          },
          {
            elements = {
              -- { id = "repl", size = 1 },
              { id = "console", size = 1 },
            },
            position = "bottom",
            size = 10
          }
        },

        mappings = {
          edit = "e",
          expand = { "<CR>", "<2-LeftMouse>" },
          open = "o",
          remove = "d",
          repl = "r",
          toggle = "t"
        },
        render = {
          indent = 1,
          max_value_lines = 100
        }
      })

      vim.keymap.set("n", "<leader>du", require("dapui").toggle, { desc = "[U]I DAP" })
      vim.keymap.set(
        "n",
        "<leader>db",
        function()
          require("dapui").float_element("breakpoints", { position="center", enter=true })
        end,
        { desc = "[B]reakpoints" }
      )
      vim.keymap.set(
        "n",
        "<leader>ds",
        function()
          require("dapui").float_element("stacks", { position="center", enter=true })
        end,
        { desc = "[S]tack traceback" }
      )
      vim.keymap.set(
        "n",
        "<leader>dw",
        function()
          require("dapui").float_element("watches", { position="center", enter=true })
        end,
        { desc = "[W]atches" }
      )
      vim.keymap.set(
        "n",
        "<leader>dr",
        function()
          require("dapui").float_element("repl", { position="center", enter=true })
        end,
        { desc = "[R]EPL" }
      )

    end,

  },
}
