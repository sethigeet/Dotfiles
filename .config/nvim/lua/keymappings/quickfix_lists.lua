-- NOTE: These bindings are only for the global quickfix lists
--       See the whichkey config for bindings realted to location lists
--
-- Easily open the quickfix list
vim.api.nvim_set_keymap("n", "<C-q>", ":TroubleToggle quickfix<CR>", { noremap = true, silent = true })
-- Easily open the location list
vim.api.nvim_set_keymap("n", "<C-l>", ":TroubleToggle loclist<CR>", { noremap = true, silent = true })

-- Navigate through the global qf list
vim.api.nvim_set_keymap("n", "<C-j>", ":cprev<CR>zz", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-k>", ":cnext<CR>zz", { noremap = true, silent = true })
