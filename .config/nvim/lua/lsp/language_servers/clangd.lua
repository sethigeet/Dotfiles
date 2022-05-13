local LanguageServer = require("lsp.language_server")

local ls = LanguageServer:create({
  server_name = "clangd",
  -- NOTE: The formatting is also handled by `clangd`
  formatters = "clang_format",
  cmd_args = { "--clang-tidy", "--cross-file-rename" },
  custom = {
    capabilities = {
      offsetEncoding = "utf-8",
    },
  },

  formatting = false,

  debugger_name = "ccppr_vsc",
  -- debugger_config = {
  -- adapters = {},
  -- configurations = {},
  -- },
})

return ls
