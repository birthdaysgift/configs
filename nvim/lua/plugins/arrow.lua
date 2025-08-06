return {
  {
    "otavioschwanck/arrow.nvim",
    config = function()
      require("arrow").setup({
        leader_key = "M",
        buffer_leader_key = "m",
        separate_by_branch = true,
        per_buffer_config = {
          lines = 1, -- Number of lines showed on preview.
        },
      })
    end,
  }
}
