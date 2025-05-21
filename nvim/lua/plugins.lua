-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- Detect tabstop and shiftwidth automatically from contents currently opened file
  'tpope/vim-sleuth',

  -- color preview
  "norcalli/nvim-colorizer.lua",

  {
    "yutkat/confirm-quit.nvim",
    event = "CmdlineEnter",
    opts = {},
  },

  {
    "kiyoon/treesitter-indent-object.nvim",
    keys = {
      {
        "ai",
        function() require("treesitter_indent_object.textobj").select_indent_outer() end,
        mode = {"x", "o"},
        desc = "Select context-aware indent (outer)",
      },
      {
        "aI",
        function() require("treesitter_indent_object.textobj").select_indent_outer(true) end,
        mode = {"x", "o"},
        desc = "Select context-aware indent (outer, line-wise)",
      },
      {
        "ii",
        function() require("treesitter_indent_object.textobj").select_indent_inner() end,
        mode = {"x", "o"},
        desc = "Select context-aware indent (inner, partial range)",
      },
      {
        "iI",
        function() require("treesitter_indent_object.textobj").select_indent_inner(true, 'V') end,
        mode = {"x", "o"},
        desc = "Select context-aware indent (inner, entire range) in line-wise visual mode",
      },
    }
  },
  -- adds indentation guides to Neovim
  {
    "lukas-reineke/indent-blankline.nvim",
    tag = "v2.20.8",  -- Use v2
    event = "BufReadPost",
    config = function()
      vim.opt.list = true
      require("indent_blankline").setup {
        space_char_blankline = " ",
        show_current_context = true,
        show_current_context_start = true,
      }
    end,
  },

  {
    'tanvirtin/vgit.nvim', branch = 'v1.0.x',
     -- or               , tag = 'v1.0.2',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-tree/nvim-web-devicons' },
    -- Lazy loading on 'VimEnter' event is necessary.
    event = 'VimEnter',
    config = function() require("vgit").setup() end,
  },

  {
    "echasnovski/mini.comment",
    opts = {
      options = {
        ignore_blank_line = true,
      },
    },
  },
  -- Collection of various small independent plugins/modules
  {
    "echasnovski/mini.nvim",
    config = function()
      require("mini.ai").setup({ n_lines = 500 })
      require("mini.surround").setup()

      local statusline = require("mini.statusline")
      statusline.setup()
      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      statusline.section_location = function()
        return '%2l:%-2v %p%%'
      end

    end,
  },

  -- prevent the cursor from moving when using shift and filter actions
  -- for some reason it breaks which-key tips for > and =
  -- but the plugin itself works fine
  {
    'gbprod/stay-in-place.nvim',
    opts = {
      set_keymaps = true,
      preserve_visual_selection = true,
    }
  },

  -- adds automatic preview for commands like "norm", etc
  -- to run norm with preview you need to use NORM
  -- as specified in plugin settings
  {
    "smjonas/live-command.nvim",
    config = function()
      require("live-command").setup(
        {
          commands = {
            NORM = { cmd = "norm" },
          },
        }
      )
    end,
  },

  -- Highlight todo, notes, etc in comments
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim'
    },
    opts = {
      signs = false
    }
  },

  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
    opts = {
      -- default options are commented
      -- you can uncomment and change them

      -- disable_filetype = { 'TelescopePrompt', 'spectre_panel' },
      -- disable_in_macro = true, -- disable when recording or executing a macro
      -- disable_in_visualblock = false, -- disable when insert after visual block mode
      -- disable_in_replace_mode = true,
      -- ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
      -- enable_moveright = true,
      -- enable_afterquote = true, -- add bracket pairs after quote
      -- enable_check_bracket_line = true, -- check bracket in same line
      -- enable_bracket_in_quote = true,
      -- enable_abbr = false, -- trigger abbreviation
      -- break_undo = true, -- switch for basic rule break undo sequence
      -- check_ts = false,
      -- map_cr = true,
      -- map_bs = true, -- map the <BS> key
      -- map_c_h = false, -- Map the <C-h> key to delete a pair
      -- map_c_w = false, -- map <c-w> to delete a pair if possible
    },
  },

  -- file breadcrumbs
  {
    'utilyre/barbecue.nvim',
    name = 'barbecue',
    version = '*',
    dependencies = {
      'SmiteshP/nvim-navic',
    },
    opts = {},
  },

  -- directory editiing as a buffer
  {
    'stevearc/oil.nvim',
    opts = {
      default_file_explorer = false,
      columns = {},  -- columns to be viewed when you open directoy in oil
      view_options = {
        show_hidden = true,
      }
    },
  },

  -- replaces the UI for messages, cmdline and the popupmenu.
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {},
    dependencies = {
      'MunifTanjim/nui.nvim',
    },
  },

  {
    "stevearc/aerial.nvim",
    dependencies = { "neovim/nvim-lspconfig", },
    opts = {
      filter_kind = false,  -- display all symbols
      float = {
        relative = "editor",
      },
      nav = {
        preview = true,
        keymaps = {
          ["q"] = "actions.close",
        },
      },
    },
  },

  {
    "nvim-pack/nvim-spectre",
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = function()
      require("neo-tree").setup({
        hijack_netrw_behavior="open_default",
        filesystem = {
          filtered_items = {
            visible = true,
          },
        },
        window = {
          position = "float",
          mappings = {
            ["<Space>"] = "none"  -- to not interfere with nvim Leader key
          }
        },
        buffers = {
          window = {
            mappings = {
              ["d"] = "buffer_delete",
            },
          },
        },
      })
    end,
  },

  -- lazygit integration inside nvim
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    -- dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    opts = {},
  },

  -- Adds git related signs to the gutter, as well as utilities for managing changes
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 0,
        ignore_whitespace = true,
        virt_text_priority = 100,
        use_focus = true,
      },
    },
  },

  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin
  --
  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
      'nvim-tree/nvim-web-devicons',  -- adds pretty icons, but requires special font.
      {
        -- If encountering errors, see telescope-fzf-native README for install instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
    config = function()
      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup({
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      })

      -- Enable telescope extensions, if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
    end,
  },

  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      { 'j-hui/fidget.nvim', opts = {} },
    },
    config = function()
      -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
      -- and elegantly composed help section, `:help lsp-vs-treesitter`

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP Specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.

      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        pyright = {
          settings = {
            python = {
              analysis = {
                ignore = { '*' },
                exclude = '.venv',
                typeCheckingMode = 'off',
              },
            },
          },
        },
        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = 'LuaJIT' },
              workspace = {
                checkThirdParty = false,
                -- Tells lua_ls where to find all the Lua files that you have loaded
                -- for your neovim configuration.
                library = {
                  '${3rd}/luv/library',
                  unpack(vim.api.nvim_get_runtime_file('', true)),
                },
                -- If lua_ls is really slow on your computer, you can try this instead:
                -- library = { vim.env.VIMRUNTIME },
              },
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      -- Ensure the servers and tools above are installed
      --  To check the current status of installed tools and/or manually install
      --  other tools, you can run
      --    :Mason
      --
      --  You can press `g?` for help in this menu
      require('mason').setup()

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'debugpy',
      })
      require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

      require("mason-lspconfig").setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
          end,
        },
      }
    end,
  },

  {"mfussenegger/nvim-dap"},

  {
    'daic0r/dap-helper.nvim',
    dependencies = { "rcarriga/nvim-dap-ui", "mfussenegger/nvim-dap" },
    config = function()
      require("dap-helper").setup()
    end
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      'mfussenegger/nvim-dap',
      'nvim-neotest/nvim-nio',
    },
    config = function()
      local dapui = require('dapui')

      dapui.setup(
        {
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
              position = "right",
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
        }
      )
    end,
  },

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

    end,
  },

  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-neotest/neotest-python",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter"
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-python")({
            -- Extra arguments for nvim-dap configuration
            -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
            dap = { justMyCode = false },
            runner = "pytest",
          })
        }
      })
    end,
  },

  {
    -- Autocompletion
    "hrsh7th/nvim-cmp",
    event = 'InsertEnter',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          -- Build Step is needed for regex support in snippets
          -- This step is not supported in many windows environments
          -- Remove the below condition to re-enable on windows
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
      },
      'saadparwaiz1/cmp_luasnip',

      -- Adds other completion capabilities.
      --  nvim-cmp does not ship with all sources by default. They are split
      --  into multiple repos for maintenance purposes.
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',

      -- If you want to add a bunch of pre-configured snippets,
      --    you can use this plugin to help you. It even has snippets
      --    for various frameworks/libraries/etc. but you will have to
      --    set up the ones that are useful for you.
      -- 'rafamadriz/friendly-snippets',
    },
    config = function()
      -- See `:help cmp`
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },

        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        mapping = cmp.mapping.preset.insert {
          -- Select the [n]ext item
          ['<C-n>'] = cmp.mapping.select_next_item(),
          -- Select the [p]revious item
          ['<C-p>'] = cmp.mapping.select_prev_item(),

          -- Accept ([y]es) the completion.
          --  This will auto-import if your LSP supports it.
          --  This will expand snippets if the LSP sent a snippet.
          ['<C-y>'] = cmp.mapping.confirm { select = true },

          -- Manually trigger a completion from nvim-cmp.
          --  Generally you don't need this, because nvim-cmp will display
          --  completions whenever it has completion options available.
          ['<C-Space>'] = cmp.mapping.complete {},

          -- Think of <c-l> as moving to the right of your snippet expansion.
          --  So if you have a snippet that's like:
          --  function $name($args)
          --    $body
          --  end
          --
          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        },
      }
    end,
  },

  -- { -- You can easily change to a different colorscheme.
  --   -- Change the name of the colorscheme plugin below, and then
  --   -- change the command in the config to whatever the name of that colorscheme is.
  --   --
  --   -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
  --   'folke/tokyonight.nvim',
  --   priority = 1000, -- Make sure to load this before all the other start plugins.
  --   config = function()
  --     ---@diagnostic disable-next-line: missing-fields
  --     require('tokyonight').setup {
  --       styles = {
  --         comments = { italic = false }, -- Disable italics in comments
  --       },
  --     }

  --     -- Load the colorscheme here.
  --     -- Like many other themes, this one has different styles, and you could load
  --     -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
  --     vim.cmd.colorscheme 'tokyonight-night'
  --   end,
  -- },

  {
    -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`
    'birthdaysgift/smoke.nvim',
    lazy = false,    -- make sure we load this during startup (lazy = false) if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins (high priority)
    config = function()
      -- Load the colorscheme here
      vim.cmd.colorscheme("smoke")
      -- You can configure highlights by doing something like
      -- vim.cmd.hi 'Comment gui=none'

    end,
  },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup {
        ensure_installed = { 'bash', 'html', 'lua', 'markdown', 'python', 'vim', 'vimdoc' },
        -- Autoinstall languages that are not installed
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      }
    end,
  },

  -- enables sticky context on scroll (same as "sticky scroll" feature in VSCode)
  {
    'nvim-treesitter/nvim-treesitter-context',
    opts = {
      mode = 'topline',
      multiline_threshold = 1,
    },
  },

  -- Useful plugin to show you pending keybinds.
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
        {
          "<leader>Q",
          function()
            vim.cmd(":wa")
            require("confirm-quit").confirm_quit_all()
          end,
          desc="[Q]uit all",
        },


        { "<C-j>", ":cnext<CR>", desc="[Q]uickfix next" },
        { "<C-k>", ":cprev<CR>", desc="[Q]uickfix prev" },

        { "-", ":Oil<CR>", desc = 'Open parent directory in oil.nvim' },
        { "<leader>h", function() require("noice").cmd("history") end, desc = "Show notifications [H]istory" },

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

        { "<leader>S", ":Spectre <CR>", desc = "[S]pectre"},

        { "<leader>N", ":Neotest summary <CR>", desc = "[N]eotest"},

        { "<leader>a", group = "[A]erial" },
        { "<leader>aa", ":AerialToggle float<CR>", desc = "[A]erial toggle" },
        { "<leader>an", ":AerialNavToggle<CR>", desc = "[A]erial[N]av toggle" },

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
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-T>.
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          -- Find references for the word under your cursor.
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          -- Fuzzy find all the symbols in your current workspace
          --  Similar to document symbols, except searches over your whole project.
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

          -- Rename the variable under your cursor
          --  Most Language Servers support renaming across files, etc.
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

          -- Opens a popup that displays documentation about the word under your cursor
          --  See `:help K` for why this keymap
          map('K', vim.lsp.buf.hover, 'Hover Documentation')

          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

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
})

