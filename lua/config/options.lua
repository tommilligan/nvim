-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--

-- Disable all animations
vim.g.snacks_animate = false

local opt = vim.opt

-- Clipboard -----------------------------------------------------------
-- Use both system clipboards. No additional OS tooling required.
opt.clipboard = "unnamed,unnamedplus"

-- Line wrapping ---------------------------------------------------------
opt.wrap = false

-- Indentation -------------------------------------------------------------
opt.expandtab = true -- use spaces instead of tabs
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true
-- opt.copyindent = true -- copy the previous indentation on autoindenting

-- Search ----------------------------------------------------------------
opt.ignorecase = true
opt.smartcase = true -- ...unless the search contains an uppercase letter
opt.incsearch = true
opt.hlsearch = true

-- UI ----------------------------------------------------------------------
opt.number = true
opt.relativenumber = false -- absolute numbers all the way
opt.signcolumn = "yes" -- always reserve space for LSP diagnostic signs, so text doesn't shift when they appear
opt.termguicolors = true
-- NOTE: colorscheme is set in the theme installation section
opt.scrolloff = 8 -- keep 8 lines visible above/below the cursor
opt.cursorline = true
opt.cursorlineopt = "number"
opt.splitright = true
opt.splitbelow = true

-- Files -------------------------------------------------------------------
opt.swapfile = false
opt.backup = false
opt.writebackup = false -- possible deprecation of above?
opt.undofile = true -- persistent undo, survives closing the file
opt.updatetime = 250 -- affects how quickly things like diagnostics/CursorHold fire
