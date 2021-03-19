-- Better window movements
for _, value in ipairs({"n", "i", "x"}) do
    vim.api.nvim_set_keymap(value, "<M-h>", "<C-w>h", {silent = true})
    vim.api.nvim_set_keymap(value, "<M-j>", "<C-w>j", {silent = true})
    vim.api.nvim_set_keymap(value, "<M-k>", "<C-w>k", {silent = true})
    vim.api.nvim_set_keymap(value, "<M-l>", "<C-w>l", {silent = true})
end
-- Terminal window navigation
for _, value in ipairs({"t", "i"}) do
    vim.api.nvim_set_keymap(value, "<M-h>", [[<C-\><C-N><C-w>h]], {noremap = true, silent = true})
    vim.api.nvim_set_keymap(value, "<M-j>", [[<C-\><C-N><C-w>j]], {noremap = true, silent = true})
    vim.api.nvim_set_keymap(value, "<M-k>", [[<C-\><C-N><C-w>k]], {noremap = true, silent = true})
    vim.api.nvim_set_keymap(value, "<M-l>", [[<C-\><C-N><C-w>l]], {noremap = true, silent = true})
end
vim.api.nvim_set_keymap("t", "<Esc>", [[<C-\><C-n>]], {noremap = true, silent = true})
-- Use alt + left,down,up,right to resize windows
vim.api.nvim_set_keymap("n", "<M-Up>", ":resize -2<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<M-Down>", ":resize +2<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<M-Left>", ":vertical resize -2<CR>", {noremap = true, silent = true})
vim.api
    .nvim_set_keymap("n", "<M-Right>", ":vertical resize +2<CR>", {noremap = true, silent = true})

-- Global Leader key
vim.g.mapleader = " "
-- let localLeader=" "
vim.api.nvim_set_keymap("n", "<Space>", "<NOP>", {noremap = true, silent = true})

-- Better indenting
vim.api.nvim_set_keymap("v", "<", "<gv", {noremap = true, silent = true})
vim.api.nvim_set_keymap("v", ">", ">gv", {noremap = true, silent = true})

-- Fixed the "Y" behavior
vim.api.nvim_set_keymap("n", "Y", "y$", {noremap = true, silent = true})

-- Better nav for omnicomplete
vim.api.nvim_set_keymap("i", "<C-j>", [[("\<C-n>")]], {noremap = true, expr = true})
vim.api.nvim_set_keymap("i", "<C-k>", [[("\<C-p>")]], {noremap = true, expr = true})

-- I hate escape more than anything else
vim.api.nvim_set_keymap("i", "jk", "<Esc>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("i", "kj", "<Esc>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("i", "<C-c>", "<Esc>", {noremap = true, silent = true})

-- Easy CAPS
vim.api.nvim_set_keymap("i", "<C-u>", "<Esc>viwUi", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<C-u>", "viwU<Esc>", {noremap = true, silent = true})

-- TAB in general mode will move to text buffer
vim.api.nvim_set_keymap("n", "<TAB>", ":bnext<CR>", {noremap = true, silent = true})
-- SHIFT-TAB will go back
vim.api.nvim_set_keymap("n", "<S-TAB>", ":bprevious<CR>", {noremap = true, silent = true})

-- Move selected line / block of text in visual mode
vim.api.nvim_set_keymap("x", "K", ':move "<-2<CR>gv-gv', {noremap = true, silent = true})
vim.api.nvim_set_keymap("x", "J", ':move ">+1<CR>gv-gv', {noremap = true, silent = true})

-- Alternate way to save
vim.api.nvim_set_keymap("n", "<C-s>", ":w<CR>", {noremap = true, silent = true})

-- Alternate way to quit
vim.api.nvim_set_keymap("n", "<C-q>", ":wq<CR>", {noremap = true, silent = true})

-- <TAB>: completion.
vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.smart_tab()",
                        {silent = true, expr = true, noremap = true})

-- Save file as sudo when no sudo permissions
vim.api.nvim_set_keymap("c", "w!!", "w !sudo tee > /dev/null %", {})

-- Center the screen after search
vim.api.nvim_set_keymap("n", "n", "nzzzv", {noremap = true})
vim.api.nvim_set_keymap("n", "N", "Nzzzv", {noremap = true})

