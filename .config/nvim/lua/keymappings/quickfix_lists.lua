local map = require("utils").map

-- NOTE: These bindings are only for the global quickfix lists
--       See the whichkey config for bindings realted to location lists

-- Easily open the quickfix list
map("n", "<C-q>", "<Cmd>copen<CR>")
-- Easily open the location list
-- map("n", "<C-l>", "<Cmd>lopen<CR>")

-- Navigate through the global qf list
-- map("n", "<C-j>", "<Cmd>cprev<CR>zz")
-- map("n", "<C-k>", "<Cmd>cnext<CR>zz")
