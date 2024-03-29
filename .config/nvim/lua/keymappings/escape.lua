local map = require("utils.wrappers").map

-- I hate escape more than anything else
-- Map jk to <Esc>
map({ "i", "c" }, "jk", "<Esc>")

-- Map kj to <Esc>
-- map({ "i", "c" }, "kj", "<Esc>")

-- Map <C-c> to <Esc>
map({ "i", "c", "x" }, "<C-c>", "<Esc>")

-- Map <Esc><Esc> to go into normal mode in a terminal
map("t", "<Esc><Esc>", [[<C-\><C-n>]])
