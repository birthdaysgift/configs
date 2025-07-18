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

      vim.keymap.set("n", "<leader>n", "<NOP>", { desc = "[N]eotree" } )
      vim.keymap.set("n", "<leader>nn", ":Neotree float toggle=true<CR>", { desc = "[N]eotree files" })
      vim.keymap.set("n", "<leader>nb", ":Neotree buffers float toggle=true<CR>", { desc = "[N]eotree [B]uffers" })
      vim.keymap.set("n", "<leader>ng", ":Neotree git_status float toggle=true<CR>", { desc = "[N]eotree [G]it" })

      vim.keymap.set(
        "n",
        "<leader>ns",
        ":Neotree float toggle=true dir=" .. vim.fn.expand("~") .. "/.local/state/nvim/swap" .. "<CR>",
        { desc = "[N]eotree [S]wap files" }
      )

    end,
  },
}
