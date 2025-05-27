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
    end,
  },
}
