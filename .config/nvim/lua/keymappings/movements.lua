local map = require("utils.wrappers").map

-- Better window movements
map({ "n", "i", "x" }, "<M-h>", "<C-w>h")
map({ "n", "i", "x" }, "<M-j>", "<C-w>j")
map({ "n", "i", "x" }, "<M-k>", "<C-w>k")
map({ "n", "i", "x" }, "<M-l>", "<C-w>l")

-- Terminal window navigation
map({ "t", "i" }, "<M-h>", [[<C-\><C-N><C-w>h]])
map({ "t", "i" }, "<M-j>", [[<C-\><C-N><C-w>j]])
map({ "t", "i" }, "<M-k>", [[<C-\><C-N><C-w>k]])
map({ "t", "i" }, "<M-l>", [[<C-\><C-N><C-w>l]])

-- Use alt + shift + h,j,k,l to resize windows
map("n", "<M-K>", "<cmd>resize -2<CR>")
map("n", "<M-J>", "<cmd>resize +2<CR>")
map("n", "<M-H>", "<cmd>vertical resize -2<CR>")
map("n", "<M-L>", "<cmd>vertical resize +2<CR>")

map("n", "0", "getline('.')[0 : col('.') - 2] =~# '^\\s\\+$' ? '0' : '^'", { expr = true })
map("v", "0", "getline('.')[0 : col('.') - 2] =~# '^\\s\\+$' ? '0' : '^'", { expr = true })
