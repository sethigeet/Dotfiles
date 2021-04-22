-- I hate escape more than anything else
-- Map jk to <Esc>
vim.api.nvim_set_keymap("i", "jk", "<Esc>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("c", "jk", "<Esc>", { noremap = true, silent = true })

-- Map kj to <Esc>
vim.api.nvim_set_keymap("i", "kj", "<Esc>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("c", "kj", "<Esc>", { noremap = true, silent = true })

-- Map <C-c> to <Esc>
vim.api.nvim_set_keymap("i", "<C-c>", "<Esc>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("c", "<C-c>", "<Esc>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "<C-c>", "<Esc>", { noremap = true, silent = true })
