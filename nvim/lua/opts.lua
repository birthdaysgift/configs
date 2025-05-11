-- See `:help vim.opt`
-- See `:help option-list`

-- To make nvim work with keybindings typed in "ru" layout
vim.opt.langmap = (
  ''
  .. 'ФA,ИB,СC,ВD,УE,АF,ПG,РH,ШI,ОJ,'
  .. 'ЛK,ДL,ЬM,ТN,ЩO,ЗP,ЙQ,КR,ЫS,ЕT,'
  .. 'ГU,МV,ЦW,ЧX,НY,ЯZ,Ж:,фa,иb,сc,'
  .. 'вd,уe,аf,пg,рh,шi,оj,лk,дl,ьm,'
  .. 'тn,щo,зp,йq,кr,ыs,еt,гu,мv,цw,'
  .. 'чx,нy,яz'
)

-- enable line numbers
vim.opt.number = true
--
-- enable relative line numbers
vim.opt.relativenumber = true

-- draw column line
vim.opt.colorcolumn = '121'

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
-- See `:help 'clipboard'`
vim.opt.clipboard = 'unnamedplus'

-- Every wrapped line will continue visually indented
vim.opt.breakindent = true

-- Use spaces when <Tab> is inserted
vim.opt.expandtab = true
-- Insert 4 spaces when ">>" pressed
vim.opt.shiftwidth = 4

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching unless \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- If this many milliseconds nothing is typed the swap file will be written to disk
vim.opt.updatetime = 250

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { space = '·', tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true

vim.g.netrw_liststyle = 3 -- tree instead of plain view
vim.g.netrw_browse_split = 3 -- open file in a new tab

-- see help for 'formatoptions' and 'fo-table'
-- to see already set options use :lua print(vim.o.formatoptions)
vim.opt.formatoptions = vim.opt.formatoptions + '2'  -- When formatting text, use the indent of the second line of a paragraph for the rest of the paragraph,
vim.opt.formatoptions = vim.opt.formatoptions + 'p'  -- Don't break lines at single spaces that follow periods.
