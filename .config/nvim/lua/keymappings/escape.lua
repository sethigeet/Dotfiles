local map = require("utils.map")

-- I hate escape more than anything else
-- Map jk to <Esc>
map.inoremap("jk", "<Esc>")
map.cnoremap("jk", "<Esc>")

-- Map kj to <Esc>
map.inoremap("kj", "<Esc>")
map.cnoremap("kj", "<Esc>")

-- Map <C-c> to <Esc>
map.inoremap("<C-c>", "<Esc>")
map.cnoremap("<C-c>", "<Esc>")
map.xnoremap("<C-c>", "<Esc>")

-- Map <Esc><Esc> to go into normal mode in a terminal
map.tnoremap("<Esc><Esc>", [[<C-\><C-n>]], { silent = true })
