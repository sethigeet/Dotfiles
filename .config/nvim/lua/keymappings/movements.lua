-- Better window movements
for _, mode in ipairs({ "n", "i", "x" }) do
    vim.api.nvim_set_keymap(mode, "<M-h>", "<C-w>h", { silent = true })
    vim.api.nvim_set_keymap(mode, "<M-j>", "<C-w>j", { silent = true })
    vim.api.nvim_set_keymap(mode, "<M-k>", "<C-w>k", { silent = true })
    vim.api.nvim_set_keymap(mode, "<M-l>", "<C-w>l", { silent = true })
end

-- Terminal window navigation
for _, mode in ipairs({ "t", "i" }) do
    vim.api.nvim_set_keymap(mode, "<M-h>", [[<C-\><C-N><C-w>h]], { noremap = true, silent = true })
    vim.api.nvim_set_keymap(mode, "<M-j>", [[<C-\><C-N><C-w>j]], { noremap = true, silent = true })
    vim.api.nvim_set_keymap(mode, "<M-k>", [[<C-\><C-N><C-w>k]], { noremap = true, silent = true })
    vim.api.nvim_set_keymap(mode, "<M-l>", [[<C-\><C-N><C-w>l]], { noremap = true, silent = true })
end
vim.api.nvim_set_keymap("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true })

-- Use alt + left,down,up,right to resize windows
vim.api.nvim_set_keymap("n", "<M-K>", ":resize -2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<M-J>", ":resize +2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<M-H>", ":vertical resize -2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<M-L>", ":vertical resize +2<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "0", "getline('.')[0 : col('.') - 2] =~# '^\\s\\+$' ? '0' : '^'",
                        { silent = true, noremap = true, expr = true })
vim.api.nvim_set_keymap("v", "0", "getline('.')[0 : col('.') - 2] =~# '^\\s\\+$' ? '0' : '^'",
                        { silent = true, noremap = true, expr = true })
