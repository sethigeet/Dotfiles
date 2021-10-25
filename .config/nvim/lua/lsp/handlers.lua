vim.diagnostic.config({
  virtual_text = { spacing = 4, prefix = "" },
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = false,
  float = {
    show_header = true,
    border = "rounded",
  },
})

-- Custom handler overrides
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
