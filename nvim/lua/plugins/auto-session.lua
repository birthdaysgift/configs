return {
  {
    'rmagatti/auto-session',
    event = "VimEnter",
    lazy = false,
    config = function()
      require("auto-session").setup({
        git_use_branch_name = true,
        git_auto_restore_on_branch_change = true,
        auto_delete_empty_sessions = false,
        cwd_change_handling = true, -- Automatically save/restore sessions when changing directories
        ignore_filetypes_on_save = {
          "checkhealth",
          "NO-NECK-PAIN",
          "DAPUI_SCOPES",
          "DAPUI_WATCHES",
          "DAPUI_DAPUI_CONSOLE",
        },
        no_restore_cmds = {
          function()
            -- load oil in case we're launching with a dir arg
            -- and there's no session for that directory
            for i = 0, vim.fn.argc() - 1 do
              if vim.fn.argv(i) == "." then
                require("oil").open()
              end
            end
          end,
        },
      })

      -- for some reason session creation and saving on exit doesn't work
      -- when using branch names so adding this autocomand explicitly here
      vim.api.nvim_create_autocmd("VimLeavePre", {
        desc = 'SaveSession',
        group = vim.api.nvim_create_augroup('autosession save', { clear = true }),
        callback = function()
          require("auto-session").SaveSession()
        end,
      })

    end,
  }
}
