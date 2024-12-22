-- Keymappings
-- NOTE: Some keybindings related to LSP are defined in `which_key` config
local map = require("utils.wrappers").map

return {
  setup = function(bufnr)
    map("n", "K", function() vim.lsp.buf.hover({ border = "rounded" }) end, { buffer = bufnr })

    map("n", "<F2>", require("lsp.helpers.rename"), { buffer = bufnr })

    map("i", "<C-s>", function() vim.lsp.buf.signature_help({ border = "rounded" }) end, { buffer = bufnr })
  end,
}
