local map = require("utils.wrappers").map

-- Easily open the quickfix list
map("n", "<C-q>", "<Cmd>copen<CR>")
-- Easily open the location list
map("n", "<C-l>", "<Cmd>lopen<CR>")

-- Navigate through the quickfix list
map("n", "[q", "<Cmd>cprev<CR>zz")
map("n", "]q", "<Cmd>cnext<CR>zz")

-- Navigate through the location list
map("n", "[l", "<Cmd>lprev<CR>zz")
map("n", "]l", "<Cmd>lnext<CR>zz")
