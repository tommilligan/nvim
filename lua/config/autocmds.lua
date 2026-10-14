-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Go: comments wrap at 90, code up to 120 (work style guide).
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("user_go", { clear = true }), -- no duplicates on re-source
  pattern = "go",
  callback = function()
    -- Only comments wrap: Go's ftplugin removes 't' from 'formatoptions'. `gqip` reflows.
    vim.opt_local.textwidth = 90
    vim.opt_local.colorcolumn = "90,120"
  end,
})
