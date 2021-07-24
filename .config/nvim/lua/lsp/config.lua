-- Custom handler overrides

-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(require("lsp.handlers.diagnostics")handler, {
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = { spacing = 0, prefix = "" },
  signs = true,
  underline = true,
  update_in_insert = true,
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

---------------------------------------------

-- Signs for diagnostics
vim.fn.sign_define("LspDiagnosticsSignError", {
  texthl = "LspDiagnosticsSignError",
  text = " ",
  numhl = "LspDiagnosticsSignError",
})
vim.fn.sign_define("LspDiagnosticsSignWarning", {
  texthl = "LspDiagnosticsSignWarning",
  text = " ",
  numhl = "LspDiagnosticsSignWarning",
})
vim.fn.sign_define("LspDiagnosticsSignInformation", {
  texthl = "LspDiagnosticsSignInformation",
  text = " ",
  numhl = "LspDiagnosticsSignInformation",
})
vim.fn.sign_define("LspDiagnosticsSignHint", {
  texthl = "LspDiagnosticsSignHint",
  text = " ",
  numhl = "LspDiagnosticsSignHint",
})

-- Symbols for autocomplete
vim.lsp.protocol.CompletionItemKind = {
  "  ", -- Text
  "  ", -- Method
  "  ", -- Function
  "  ", -- Constructor
  " ﴲ ", -- Field
  "[]", -- Variable
  "  ", -- Class
  " ﰮ ", -- Interface
  "  ", -- Module
  " 襁", -- Property
  " 塞", -- Unit
  "  ", -- Value
  " 練", -- Enum
  "  ", -- Keyword
  "  ", -- Snippet
  "  ", -- Color
  "  ", -- File
  "  ", -- Reference
  "  ", -- Folder
  "  ", -- EnumMember
  " ﲀ ", -- Constant
  "  ", -- Struct
  "  ", -- Event
  "  ", -- Operator
  "  ", -- TypeParameter
}

-- Keymappings
-- NOTE: Some keybindings related to LSP are defined in `which_key` config
vim.api.nvim_set_keymap("n", "K", ":lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true })
