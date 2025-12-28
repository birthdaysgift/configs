return {
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
        filesystem = {
          hijack_netrw_behavior="disabled",
          bind_to_cwd = false,
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

      vim.keymap.set("n", "<leader>n", "<NOP>", { desc = "[N]eotree" } )
      vim.keymap.set("n", "<leader>E", ":Neotree dir=" .. vim.env.PWD .. "<CR>", { desc = "[N]eotree project root" })

      vim.keymap.set("n", "<leader>nb", ":Neotree buffers<CR>", { desc = "[N]eotree [B]uffers" })
      vim.keymap.set("n", "<leader>ng", ":Neotree git_status<CR>", { desc = "[N]eotree [G]it" })
      vim.keymap.set("n", "<leader>ns", ":Neotree dir=~/.local/state/nvim/swap<CR>", { desc = "[N]eotree [S]wap files" })

    end,
  },
}
