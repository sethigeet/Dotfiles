-- Keymappings
-- NOTE: Some keybindings related to LSP are defined in `which_key` config
local map = require("utils.wrappers").map

return {
  setup = function(bufnr)
    map("n", "K", vim.lsp.buf.hover, { buffer = bufnr })

    map("n", "<F2>", require("lsp.helpers.rename"), { buffer = bufnr })
  end,
}
