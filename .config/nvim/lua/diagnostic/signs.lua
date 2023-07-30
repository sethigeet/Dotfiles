-- Signs for diagnostics
vim.fn.sign_define("DiagnosticSignError", {
  texthl = "DiagnosticError",
  text = " ",
  numhl = "DiagnosticError",
})
vim.fn.sign_define("DiagnosticSignWarn", {
  texthl = "DiagnosticWarn",
  text = " ",
  numhl = "DiagnosticWarn",
})
vim.fn.sign_define("DiagnosticSignInfo", {
  texthl = "DiagnosticInfo",
  text = " ",
  numhl = "DiagnosticInfo",
})
vim.fn.sign_define("DiagnosticSignHint", {
  texthl = "DiagnosticHint",
  text = " ",
  numhl = "DiagnosticHint",
})
