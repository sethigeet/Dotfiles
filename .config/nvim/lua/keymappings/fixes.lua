local map = require("utils.wrappers").map

-- Saner "n" and "N" behavior
-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
-- NOTE: Currently being handled in the `hlslens` plugin
-- map({ "n", "x", "o" }, "n", "'Nn'[v:searchforward]", { expr = true })
-- map({ "n", "x", "o" }, "N", "'nN'[v:searchforward]", { expr = true })

-- Make <number>j/k register in jumplist too (only when <number> > 5)
map("n", "j", [[(v:count > 5 ? "m'" . v:count : "") . "j"]], { expr = true })
map("n", "k", [[(v:count > 5 ? "m'" . v:count : "") . "k"]], { expr = true })

-- Add more undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")
