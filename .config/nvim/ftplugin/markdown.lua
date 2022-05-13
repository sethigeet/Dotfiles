vim.opt_local.wrap = true
vim.opt_local.spell = true

local map = require("utils.wrappers").map
map({ "n", "v" }, "j", "gj")
map({ "n", "v" }, "k", "gk")
