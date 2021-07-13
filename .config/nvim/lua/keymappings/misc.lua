-- Better indenting
vim.api.nvim_set_keymap("v", "<", "<gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", ">", ">gv", { noremap = true, silent = true })

-- Better nav for omnicomplete
vim.api.nvim_set_keymap("i", "<C-j>", [[("\<C-n>")]], { noremap = true, expr = true })
vim.api.nvim_set_keymap("i", "<C-k>", [[("\<C-p>")]], { noremap = true, expr = true })

-- Easy CAPS
vim.api.nvim_set_keymap("i", "<M-u>", "<Esc>viwUi", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<M-u>", "viwU<Esc>", { noremap = true, silent = true })

-- Center the screen after search
vim.api.nvim_set_keymap("n", "n", "nzzzv", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "N", "Nzzzv", { silent = true, noremap = true })

-- Substitute command shortcut
vim.api.nvim_set_keymap("n", "S", ":%s//g<Left><Left>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("v", "S", ":s//g<Left><Left>", { silent = true, noremap = true })
