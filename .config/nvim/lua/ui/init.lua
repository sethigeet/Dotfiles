-- Override vim.ui methods
vim.ui.input = require("ui.input")
vim.ui.select = require("ui.select")

-- Improve default quickfix list ui
require("ui.quickfix")
