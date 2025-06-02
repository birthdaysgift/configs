-- Adds git related signs to the gutter, as well as utilities for managing changes

return {
  {
    'lewis6991/gitsigns.nvim',

    config = function()
      require("gitsigns").setup({
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
      })

      vim.keymap.set("n", "<leader>g", "<NOP>", { desc = "[G]it" })
      vim.keymap.set("n", "<leader>gG", ":Gitsigns<CR>", { desc = "[G]itsigns" })
      vim.keymap.set("n", "<leader>gb", ":Gitsigns toggle_current_line_blame<CR>", { desc = "[B]lame line" })
      vim.keymap.set("n", "<leader>gd", ":Gitsigns toggle_deleted<CR>", { desc = "[D]eleted lines" })
      vim.keymap.set("n", "<leader>gB", ":Gitsigns blame<CR>", { desc = "[B]lame" })
      vim.keymap.set("n", "<leader>gD", ":Gitsigns diffthis<CR>", { desc = "[D]iff" })
      vim.keymap.set("n", "<leader>gh", "<NOP>", { desc = "[H]unk"  })
      vim.keymap.set("n", "<leader>ghs", ":Gitsigns stage_hunk<CR>", { desc = "[S]tage hunk" })
      vim.keymap.set("n", "<leader>ghu", ":Gitsigns undo_stage_hunk<CR>", { desc = "[U]ndo stage hunk" })
      vim.keymap.set("n", "<leader>ghR", ":Gitsigns reset_hunk<CR>", { desc = "[R]eset hunk" })
      vim.keymap.set("n", "<leader>ghv", ":Gitsigns select_hunk<CR>", { desc = "[V]isually select hunk" })
      vim.keymap.set("n", "<leader>ghn", ":Gitsigns next_hunk<CR>", { desc = "[N]ext hunk" })
      vim.keymap.set("n", "<leader>ghp", ":Gitsigns prev_hunk<CR>", { desc = "[P]rev hunk" })
      vim.keymap.set("n", "<leader>ghP", ":Gitsigns preview_hunk_inline<CR>", { desc = "[P]review hunk" })
      vim.keymap.set(
        "n",
        "<leader>gI",
        function()
          require("gitsigns").toggle_deleted()
          require("gitsigns").toggle_word_diff()
          require("gitsigns").toggle_linehl()
        end,
        { desc = "[I]nline hunks (all)" }
      )

    end,
  },
}
