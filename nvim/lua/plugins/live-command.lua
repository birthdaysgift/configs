-- adds automatic preview for commands like "norm", etc
-- to run norm with preview you need to use NORM
-- as specified in plugin settings

return {
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
}

