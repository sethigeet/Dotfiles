local map = require("utils.map")

-- NOTE: These bindings are only for the global quickfix lists
--       See the whichkey config for bindings realted to location lists
--
-- Easily open the quickfix list
map.nnoremap("<C-q>", ":copen<CR>")
-- Easily open the location list
map.nnoremap("<C-l>", ":lopen<CR>")

-- Navigate through the global qf list
map.nnoremap("<C-j>", ":cprev<CR>zz")
map.nnoremap("<C-k>", ":cnext<CR>zz")
