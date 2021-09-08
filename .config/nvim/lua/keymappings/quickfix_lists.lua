local map = require("utils.map")

-- NOTE: These bindings are only for the global quickfix lists
--       See the whichkey config for bindings realted to location lists

-- Easily open the quickfix list
map.nnoremap("<C-q>", "<cmd>copen<CR>")
-- Easily open the location list
-- map.nnoremap("<C-l>", "<cmd>lopen<CR>")

-- Navigate through the global qf list
-- map.nnoremap("<C-j>", "<cmd>cprev<CR>zz")
-- map.nnoremap("<C-k>", "<cmd>cnext<CR>zz")
