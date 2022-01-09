-- Keymappings
-- NOTE: Some keybindings related to LSP are defined in `which_key` config
local map = require("utils").map

map("n", "K", vim.lsp.buf.hover)
