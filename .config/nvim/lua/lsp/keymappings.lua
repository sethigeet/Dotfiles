-- Keymappings
-- NOTE: Some keybindings related to LSP are defined in `which_key` config
local map = require("utils.map")

map.nnoremap("K", "<cmd>lua vim.lsp.buf.hover()<CR>")
