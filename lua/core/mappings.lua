local utils = require("utils")
-- Rebind Ctrl+L to ESC
vim.keymap.set("i", "<C-l>", "<ESC>")

-- fzf
vim.keymap.set("n", "<C-p>", function()
    require("fzf-lua").git_files()
end, { silent = true })
vim.keymap.set("n", "<C-f>", function()
    -- Use Ctrl-F to ripgrep through files
    require("fzf-lua").live_grep()
end)

-- NVIM-TREE --
vim.keymap.set("n", "<C-n>", "<cmd>NvimTreeToggle<cr>")
vim.keymap.set("n", "<leader>o", "<cmd>NvimTreeFindFile<cr>")

-- TROUBLE --
vim.keymap.set("n", "<C-e>", "<cmd>TroubleToggle document_diagnostics<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<C-t>", "<cmd>TroubleToggle workspace_diagnostics<cr>", { silent = true, noremap = true })

-- TERMINAL
vim.keymap.set("t", "<C-l>", "<C-\\><C-n>")
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
