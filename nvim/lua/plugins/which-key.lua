-- Useful plugin to show you pending keybinds.

return {
  {
    -- NOTE: Plugins can also be configured to run lua code when they are loaded.
    --
    -- This is often very useful to both group configuration, as well as handle
    -- lazy loading plugins that don't need to be loaded immediately at startup.
    --
    -- For example, in the following configuration, we use:
    --  event = 'VimEnter'
    --
    -- which loads which-key before all the UI elements are loaded. Events can be
    -- normal autocommands events (`:help autocmd-events`).
    --
    -- Then, because we use the `config` key, the configuration only runs
    -- after the plugin has been loaded:
    --  config = function() ... end
    'folke/which-key.nvim',
    event = 'VimEnter',
    config = function() -- This is the function that runs, AFTER loading
      require('which-key').setup({
        delay = 0,
        icons = { mappings = false },
      })

      require("which-key").add({
        { "<C-j>", ":cnext<CR>", desc="[Q]uickfix next" },
        { "<C-k>", ":cprev<CR>", desc="[Q]uickfix prev" },

        { "-", ":Oil<CR>", desc = 'Open parent directory in oil.nvim' },

        { "C-f", group="Tab navigation"},
        { "<C-f>1", "1gt", desc="Tab 1" },
        { "<C-f>2", "2gt", desc="Tab 2" },
        { "<C-f>3", "3gt", desc="Tab 3" },
        { "<C-f>4", "4gt", desc="Tab 4" },
        { "<C-f>5", "5gt", desc="Tab 4" },
        { "<C-f>6", "6gt", desc="Tab 4" },
        { "<C-f>7", "7gt", desc="Tab 4" },
        { "<C-f>8", "8gt", desc="Tab 4" },
        { "<C-f>9", "9gt", desc="Tab 4" },
        { "<C-f>n", ":tabnew<CR>", desc="New tab" },
        { "<C-f>x", ":tabclose<CR>", desc="Close tab" },

        { "<leader>C", ":ColorizerToggle<CR>", desc = "[C]olorizer toggle" },

        { "<leader>n", group = "[N]eotree" },
        { "<leader>nn", ":Neotree position=float toggle=true<CR>", desc = "[N]eotree files" },
        { "<leader>nb", ":Neotree buffers position=float toggle=true<CR>", desc = "[N]eotree [B]uffers" },
        { "<leader>ng", ":Neotree git_status position=float toggle=true<CR>", desc = "[N]eotree [G]it" },

        { "<leader>g", group = "[G]it" },
        { "<leader>gG", ":Gitsigns<CR>", desc = "[G]itsigns" },
        { "<leader>gb", ":Gitsigns toggle_current_line_blame<CR>", desc = "[B]lame line" },
        { "<leader>gd", ":Gitsigns toggle_deleted<CR>", desc = "[D]eleted lines" },
        { "<leader>gB", ":Gitsigns blame<CR>", desc = "[B]lame" },
        { "<leader>gD", ":Gitsigns diffthis<CR>", desc = "[D]iff" },
        {
          "<leader>gI",
          function()
            require("gitsigns").toggle_deleted()
            require("gitsigns").toggle_word_diff()
            require("gitsigns").toggle_linehl()
          end,
          desc = "[I]nline hunks (all)",
        },
        { "<leader>gh", group = "[H]unk" },
        { "<leader>ghs", ":Gitsigns stage_hunk<CR>", desc = "[S]tage hunk" },
        { "<leader>ghu", ":Gitsigns undo_stage_hunk<CR>", desc = "[U]ndo stage hunk" },
        { "<leader>ghR", ":Gitsigns reset_hunk<CR>", desc = "[R]eset hunk" },
        { "<leader>ghv", ":Gitsigns select_hunk<CR>", desc = "[V]isually select hunk" },
        { "<leader>ghn", ":Gitsigns next_hunk<CR>", desc = "[N]ext hunk" },
        { "<leader>ghp", ":Gitsigns prev_hunk<CR>", desc = "[P]rev hunk" },
        { "<leader>ghP", ":Gitsigns preview_hunk_inline<CR>", desc = "[P]review hunk" },

        { "<leader>s", group = "[S]earch with Telescope" },
        { "<leader>sh", require("telescope.builtin").help_tags, desc = "[H]elp" },
        { "<leader>sk", require("telescope.builtin").keymaps, desc = '[S]earch [K]eymaps' },
        { "<leader>sf", require("telescope.builtin").find_files, desc = '[S]earch [F]iles' },
        { "<leader>ss", require("telescope.builtin").builtin, desc = '[S]earch [S]elect Telescope' },
        { "<leader>sw", require("telescope.builtin").grep_string, desc = '[S]earch current [W]ord' },
        { "<leader>sg", require("telescope.builtin").live_grep, desc = '[S]earch by [G]rep' },
        { "<leader>sd", require("telescope.builtin").diagnostics, desc = '[S]earch [D]iagnostics' },
        { "<leader>sj", require("telescope.builtin").jumplist, desc = '[S]earch [J]umplist' },
        { "<leader>sr", require("telescope.builtin").resume, desc = '[S]earch [R]esume' },
        { "<leader>s.", require("telescope.builtin").oldfiles, desc = '[S]earch Recent Files ("." for repeat)' },
        { "<leader><leader>", require("telescope.builtin").buffers, desc = '[ ] Find existing buffers' },
        { "<leader>/", require("telescope.builtin").current_buffer_fuzzy_find, desc = '[/] Fuzzily search in current buffer' },
        {
          "<leader>s/",
          function()
            require("telescope.builtin").live_grep({
              grep_open_files = true,
              prompt_title = 'Live Grep in Open Files',
            })
          end,
          desc = '[S]earch [/] in Open Files',
        },

        { "<leader>r", group = "[R]ename" },
        { "<leader>t", group = "[T]oggle" },
        { "<leader>b", group = "[B]reakpoints" },
        { "<leader>c", group = "[C]ode" },
        { "<leader>w", group = "[W]orkspace" },
        { "<leader>L", ":LazyGit<CR>", desc = '[L]azyGit' },

        { "<leader>d", group = "[D]ebug" },
        { "<leader>bb", require("dap").toggle_breakpoint, desc = "[B]reakpoint" },
        { "<leader>dl", require("dap").run_last, desc = "Run [L]ast" },
        { "<leader>dc", require("dap").continue, desc = "[C]ontinue" },
        { "<leader>dC", require("dap").run_to_cursor, desc = "[C]ontinue to [C]ursor" },
        { "<leader>dk", require("dap").step_into, desc = "Step into" },
        { "<leader>dj", require("dap").step_over, desc = "Step over" },
        { "<leader>do", require("dap").step_out, desc = "Step out" },
        { "<leader>dt", require("dap").terminate, desc = "[T]erminate" },
        { "<leader>du", require("dapui").toggle, desc = "[U]I DAP" },
        { "<leader>dp", require("dap-python").test_method, desc = "[P]ytest method under cursor"},
        {
          "<leader>db",
          function()
            require("dapui").float_element("breakpoints", { position="center", enter=true })
          end,
          desc = "[B]reakpoints",
        },
        {
          "<leader>ds",
          function()
            require("dapui").float_element("stacks", { position="center", enter=true })
          end,
          desc = "[S]tack traceback",
        },
        {
          "<leader>dw",
          function()
            require("dapui").float_element("watches", { position="center", enter=true })
          end,
          desc = "[W]atches",
        },
        {
          "<leader>dr",
          function()
            require("dapui").float_element("repl", { position="center", enter=true })
          end,
          desc = "[R]EPL",
        },
        {
          "<leader>bc",
          function()
            require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: '))
          end,
          desc = "[C]onditional breakpoint"
        },
        {
          "<leader>bl",
          function()
            require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
          end,
          desc = "[L]ogpoint"
        },
      })

      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed

          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end

        end,
      })
    end,
  },
}
