-- Signs for DAP
vim.fn.sign_define("DapBreakpoint", {
  text = "",
  texthl = "DiagnosticError",
  linehl = "",
  numhl = "",
})
vim.fn.sign_define("DapBreakpointCondition", {
  text = "",
  texthl = "DiagnosticWarn",
  linehl = "",
  numhl = "",
})
vim.fn.sign_define("DapLogPoint", {
  text = "",
  texthl = "DiagnosticWarn",
  linehl = "",
  numhl = "",
})
vim.fn.sign_define("DapBreakpointRejected", {
  text = "󱃓",
  texthl = "DiagnosticHint",
  linehl = "",
  numhl = "",
})
vim.fn.sign_define("DapStopped", {
  text = "",
  texthl = "DiagnosticInfo",
  linehl = "DiagnosticUnderlineInfo",
  numhl = "DiagnosticInfo",
})
