-- list actually set keymaps
-- :map

-- disable search highlights
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Center cursor after jumps
vim.keymap.set('n', 'G', 'Gzz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-o>', '<C-o>zz')
vim.keymap.set('n', '<C-i>', '<C-i>zz')


vim.keymap.set("n", "<leader>X", "<cmd>!chmod +x %<CR>", { silent = true })

-- quickfix list navigation
vim.keymap.set("n", "<Down>", ":cnext<CR>", { desc="[Q]uickfix next" })
vim.keymap.set("n", "<Up>", ":cprev<CR>", { desc="[Q]uickfix prev" })

-- join lines without moving cursor
vim.keymap.set("n", "J", "mzJ`z")

local wrap_enabled = true
vim.keymap.set(
  "n",
  "<leader>ow",
  function()
    wrap_enabled = not wrap_enabled
    vim.api.nvim_set_option_value("wrap", wrap_enabled, {scope = "local"})
  end,
  { desc = "[W]rap toggle" }
)

-- paste in visual mode without overriding copy register
vim.keymap.set("v", "p", "P")

vim.keymap.set("i", "<C-k>", "<C-t>", { noremap = true, silent = true })

vim.keymap.set(
  "v",
  "/",
  function()
    vim.api.nvim_input("<Esc>")  -- exit to normal mode
    vim.api.nvim_input("/")  -- start search
    vim.api.nvim_input("\\%V")  -- enter prefix which allows to search in previously selected range
  end
)

vim.keymap.set('v', 'p', 'ip', { noremap = true, silent = true })
vim.keymap.set('v', 'W', 'iW', { noremap = true, silent = true })
vim.keymap.set('v', 'w', 'iw', { noremap = true, silent = true })
vim.keymap.set('o', 'w', 'iw', { noremap = true, silent = true })
vim.keymap.set('o', 'W', 'iW', { noremap = true, silent = true })
vim.keymap.set('o', 'p', 'ip', { noremap = true, silent = true })


vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("v", "V", "$o_o")


local function change_win_width(win, step)
  vim.api.nvim_win_set_width(win, vim.api.nvim_win_get_width(win) + step)
  vim.cmd("redraw")
end

local function change_win_height(win, step)
  vim.api.nvim_win_set_height(win, vim.api.nvim_win_get_height(win) + step)
  vim.cmd("redraw")
end

local function window_horizontal_side(win)
  win = win or vim.api.nvim_get_current_win()
  local pos = vim.api.nvim_win_get_position(win)
  local col = pos[2]
  local width = vim.api.nvim_win_get_width(win)
  local screen_width = vim.o.columns

  if col == 0 then
    return "left"
  elseif col + width >= screen_width then
    return "right"
  else
    return "middle"
  end
end

local function window_vertical_side(win)
  win = win or vim.api.nvim_get_current_win()
  local pos = vim.api.nvim_win_get_position(win)
  local row = pos[1]                     -- top row of the window
  local height = vim.api.nvim_win_get_height(win)
  local screen_height = vim.o.lines      -- total number of screen lines

  if row == 0 then
    return "top"
  elseif row + height >= screen_height then
    return "bottom"
  else
    return "middle"
  end
end

local function enter_resize_mode(
  win,
  step,
  increase_width_char,
  decrease_width_char,
  increase_height_char,
  decrease_height_char
)
  vim.cmd('echo "Resize mode: hjkl - resize, Esc: exit"')

  while true do
    local key = vim.fn.getchar()
    local char = nil
    if type(key) == "number" then
      char = vim.fn.nr2char(key)
    elseif type(key) == "string" then
      char = key
    end

    if char == increase_width_char then
      change_win_width(win, step)
    elseif char == decrease_width_char then
      change_win_width(win, -step)

    elseif char == increase_height_char then
      change_win_height(win, 2)
    elseif char == decrease_height_char then
      change_win_height(win, -2)

    elseif char == "\27" then  -- ESC
      break
    end
  end

  vim.cmd('echo "Exited resize mode"')
end

vim.keymap.set(
  "n",
  "<C-w><C-r>",
  function()

    local win = vim.api.nvim_get_current_win()
    local horizontal_side = window_horizontal_side(win)
    local vertical_side = window_vertical_side(win)
    print(vertical_side)

    local step = 5
    local increase_width_char = "l"
    local decrease_width_char = "h"
    local increase_height_char = "j"
    local decrease_height_char = "k"

    if horizontal_side ~= "left" then
      increase_width_char = "h"
      decrease_width_char = "l"
    end
    if vertical_side ~= "top" then
      increase_height_char = "k"
      decrease_height_char = "j"
    end

    enter_resize_mode(
      win,
      step,
      increase_width_char,
      decrease_width_char,
      increase_height_char,
      decrease_height_char
    )
  end,
  { desc = "[R]esize mode" }
)

vim.keymap.set("n", "yf", ":%y<CR>", { desc = "[Y]ank [F]ile"})
vim.keymap.set('n', 'yl', function()
  local pos = vim.api.nvim_win_get_cursor(0)
  vim.cmd('normal! _y$')
  vim.api.nvim_win_set_cursor(0, pos)
end, { desc = "[Y]ank [L]ine" })

vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "[W]rite buffer" })
vim.keymap.set("n", "<leader>q", ":quitall!<CR>", { desc = "[Q]uit nvim" })


vim.keymap.set("n", "<C-e>", "$", { noremap = true, silent = true })
vim.keymap.set("v", "<C-e>", "$", { noremap = true, silent = true })
vim.keymap.set("i", "<C-e>", "<esc>A", { noremap = true, silent = true })
vim.keymap.set("i", "<C-a>", "<esc>I", { noremap = true, silent = true })
vim.keymap.set("o", "<C-e>", "$", { noremap = true, silent = true })

vim.keymap.set("n", "<C-n>", "*zz", { noremap = true, silent =  true })
vim.keymap.set("n", "n", "nzz", { noremap = true, silent =  true })
vim.keymap.set("n", "N", "Nzz", { noremap = true, silent =  true })

-- tab navigation
vim.keymap.set("n", "<C-f>", "<NOP>", { desc="Tab navigation" })
vim.keymap.set("n", "<C-f>1", "1gt", { desc="Tab 1" })
vim.keymap.set("n", "<C-f>2", "2gt", { desc="Tab 2" })
vim.keymap.set("n", "<C-f>3", "3gt", { desc="Tab 3" })
vim.keymap.set("n", "<C-f>4", "4gt", { desc="Tab 4" })
vim.keymap.set("n", "<C-f>5", "5gt", { desc="Tab 5" })
vim.keymap.set("n", "<C-f>6", "6gt", { desc="Tab 6" })
vim.keymap.set("n", "<C-f>7", "7gt", { desc="Tab 7" })
vim.keymap.set("n", "<C-f>8", "8gt", { desc="Tab 8" })
vim.keymap.set("n", "<C-f>9", "9gt", { desc="Tab 9" })
vim.keymap.set("n", "<C-f>a", "1gt", { desc="Tab 1 (short)" })
vim.keymap.set("n", "<C-f>s", "2gt", { desc="Tab 2 (short)" })
vim.keymap.set("n", "<C-f>d", "3gt", { desc="Tab 3 (short)" })
vim.keymap.set("n", "<C-f>f", "4gt", { desc="Tab 4 (short)" })
vim.keymap.set("n", "<C-f>n", ":tabnew<CR>", { desc="New tab" })
vim.keymap.set("n", "<C-f>x", ":tabclose<CR>", { desc="Close tab" })

vim.keymap.set("n", "<C-f>i", ":-tabmove<CR>", { desc="Move tab left" })
vim.keymap.set("n", "<C-f>o", ":+tabmove<CR>", { desc="Move tab right" })

local last_tab = nil
vim.api.nvim_create_autocmd("TabLeave", {
    callback = function()
        last_tab = vim.api.nvim_get_current_tabpage()
    end,
})
vim.keymap.set(
  "n",
  "<C-f><C-f>",
  function()
    if last_tab and vim.api.nvim_tabpage_is_valid(last_tab) then
      vim.api.nvim_set_current_tabpage(last_tab)
    else
      print("No previous tab to switch to.")
    end
  end,
  { desc = "Switch to previous tab" }
)

local show_diagnostics = false
vim.keymap.set("n", "<leader>D", function()

  show_diagnostics = not show_diagnostics

  vim.diagnostic.config({
    virtual_lines = show_diagnostics and {
      format = function(diagnostic)
        -- Customize the format to include the source
        return string.format("[%s] %s", diagnostic.source, diagnostic.message)
      end,
    },
  })

end, { desc = "Toggle virtual lines for diagnostics" })
