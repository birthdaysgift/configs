-- Fuzzy Finder for everything - files, lsp, etc.

local utils = require('utils')


local function search_filesystem()
  require("telescope.pickers").new({}, {
    prompt_title = "Filesystem",
    finder = require("telescope.finders").new_oneshot_job(
      {
        "fd",
        "--hidden",
        "--no-ignore",
        "--exclude", ".git",
        "--exclude", ".venv*",
        "--exclude", "__pycache__",
        "--exclude", ".mypy_cache",
        "--exclude", "node_modules",
      },
      { cwd = vim.uv.cwd() }
    ),
    sorter = require("telescope.config").values.generic_sorter(),
    previewer = require("telescope.previewers").new_termopen_previewer({
      get_command = function(entry)
        local stat = vim.uv.fs_stat(entry.value)
        if stat and stat.type == "directory" then
          return { "tree", "-L", "1", "-F", "--dirsfirst", "-a", "-n", entry.value }
        end
        return { "bat", "--number", entry.value }
      end
    }),
    attach_mappings = function(_, _)
      require("telescope.actions").select_default:replace(
        function()
          require("telescope.actions").close(vim.api.nvim_get_current_buf())
          local path = require("telescope.actions.state").get_selected_entry().value

          local stat = vim.uv.fs_stat(path)

          if not stat then
            print("Path does not exist")
            return
          end

          if stat.type == "directory" then
            require("oil").open_float(path, {  preview = {vertical = true} })
            return
          end

          vim.cmd("edit " .. vim.fn.fnameescape(path))
        end
      )
      return true
    end
  }):find()
end


return {
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',  -- adds pretty icons, but requires special font.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function() return (vim.fn.executable 'make' == 1) end
      },
    },
    config = function()

      require('telescope').setup({
        defaults = {
          mappings = {
            i = {
              ["<Esc>"] = require('telescope.actions').close,
              ["<C-s>"] = require("telescope.actions").select_horizontal,
            }
          },
          vimgrep_arguments = utils.list_concat(
            require("telescope.config").values.vimgrep_arguments,
            {
              "--hidden",  -- include hidden (dot-prefixed) files, like .bashrc
              "--no-ignore",  -- include gitignored file and dirs
              "--glob", "!**/.git/*", -- exclude .git/ directory files
              "--glob", "!**/node_modules/*", -- exclude node_modules/ directory files
              "--glob", "!**/.venv*/*", -- exclude .venv*/ directory files
              "--glob", "!**/.mypy_cache/*", -- exclude .mypy_cache directories and files
              "--glob", "!**/__pycache__", -- exclude __pycache__ directories and files
            }
          ),
        },
      })

      local actions = require('telescope.actions')
      local action_state = require('telescope.actions.state')
      local pickers = require('telescope.pickers')
      local finders = require('telescope.finders')
      local conf = require('telescope.config').values

      local workspace_dir = vim.loop.cwd()

      local function telescope_find_dirs()
        pickers.new({}, {
          prompt_title = "Find Directory",
          finder = finders.new_oneshot_job(
            {
              "fd",
              "--type",
              "d",
              "--hidden",
              "--no-ignore",
              "--exclude", ".git",
              "--exclude", ".venv*",
              "--exclude", "__pycache__",
              "--exclude", ".mypy_cache",
              "--exclude", "node_modules",
            },
            { cwd = workspace_dir }
          ),
          sorter = conf.generic_sorter({}),
          attach_mappings = function(prompt_bufnr, map)
            local function cd_dir()
              local selection = action_state.get_selected_entry()
              actions.close(prompt_bufnr)
              vim.cmd("cd " .. workspace_dir)
              vim.cmd("cd " .. selection[1])
              print("Changed directory to: " .. selection[1])
            end

            map('i', '<CR>', cd_dir)
            map('n', '<CR>', cd_dir)
            return true
          end,
        }):find()
      end

      vim.keymap.set('n', '<leader>c', telescope_find_dirs, { desc = "[C]hange working directory" })
      vim.keymap.set(
        'n',
        '<leader>.',
        function()
          vim.cmd("cd " .. workspace_dir)
          print("Changed directory to: " .. workspace_dir)
        end,
        { desc = "Go to workspace directory" }
      )

      local builtin = require("telescope.builtin")
      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")

      vim.keymap.set("n", "<leader>/", function()
        builtin.current_buffer_fuzzy_find({
          attach_mappings = function(_, map)
            local move_to_match = function(prompt_bufnr)
              local entry = action_state.get_selected_entry()
              local search = action_state.get_current_line()
              actions.close(prompt_bufnr)

              -- Move cursor to the selected line first
              vim.api.nvim_win_set_cursor(0, { entry.lnum, 0 })

              -- Then search for the term in that line
              if search ~= "" then
                local line = vim.api.nvim_get_current_line()
                local start_col = string.find(line, vim.pesc(search))
                if start_col then
                  vim.api.nvim_win_set_cursor(0, { entry.lnum, start_col })
                end
              end
            end

            map("i", "<CR>", move_to_match)
            map("n", "<CR>", move_to_match)
            return true
          end,
        })
      end, { desc = "[/] Fuzzy search and jump to match in current buffer" })

      -- Enable telescope extensions
      require('telescope').load_extension("fzf")

      vim.keymap.set({"n", "v"}, "<leader>s", "<NOP>", { desc = "[S]earch with Telescope" })
      vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[H]elp" })
      vim.keymap.set("n", "<leader>sk", require("telescope.builtin").keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set("n", "<leader>sf", search_filesystem, { desc = '[S]earch [F]ilesystem' })
      vim.keymap.set("n", "<leader>ss", require("telescope.builtin").builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = '[S]earch by [G]rep' } )
      vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set("n", "<leader>sj", require("telescope.builtin").jumplist, { desc = '[S]earch [J]umplist' })
      vim.keymap.set("n", "<leader>sr", require("telescope.builtin").resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set({"n", "v"}, "<leader>s:", require("telescope.builtin").command_history, { desc = '[S]earch [:] history' })
      vim.keymap.set("n", "<leader>s/", require("telescope.builtin").search_history, { desc = '[S]earch [/] history' })
      vim.keymap.set("n", "<leader><leader>", require("telescope.builtin").buffers, { desc = '[ ] Existing buffers' })
    end,
  },
}
