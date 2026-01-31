return {
  {
    -- 'isakbm/gitgraph.nvim',
    dir="/home/mint/code/gitgraph.nvim",
    opts = {
      git_cmd = "git",
      -- symbols = {
      --   merge_commit = '',
      --   commit = '',
      --   merge_commit_end = '',
      --   commit_end = '',
      --
      --   -- Advanced symbols
      --   GVER = '',
      --   GHOR = '',
      --   GCLD = '',
      --   GCRD = '╭',
      --   GCLU = '',
      --   GCRU = '',
      --   GLRU = '',
      --   GLRD = '',
      --   GLUD = '',
      --   GRUD = '',
      --   GFORKU = '',
      --   GFORKD = '',
      --   GRUDCD = '',
      --   GRUDCU = '',
      --   GLUDCD = '',
      --   GLUDCU = '',
      --   GLRDCL = '',
      --   GLRDCR = '',
      --   GLRUCL = '',
      --   GLRUCR = '',
      -- },
      format = {
        timestamp = '%H:%M:%S %d-%m-%Y',
        fields = { 'hash', 'timestamp', 'author', 'branch_name', 'tag' },
      },
      hooks = {
        on_select_commit = function(commit)
          print('selected commit:', commit.hash)
        end,
        on_select_range_commit = function(from, to)
          print('selected range:', from.hash, to.hash)
        end,
      },
    },
    keys = {
      {
        "<leader>gl",
        function()
          require('gitgraph').draw({}, { all = true, max_count = 50 })
        end,
        desc = "GitGraph - Draw",
      },
      {
        "<leader>gt",
        function()
          require('gitgraph').test()
        end,
        desc = "GitGraph - Draw",
      },
    },
  },


  {
    "rbong/vim-flog",
    lazy = true,
    cmd = { "Flog", "Flogsplit", "Floggit" },
    dependencies = {
      "tpope/vim-fugitive",
    },
  },

  {
    dir="/home/mint/code/nvgraph",
    config = function()
      local graph = require("nvgraph")
      vim.keymap.set("n", "<leader>gg", graph.open)
    end
  },
}

