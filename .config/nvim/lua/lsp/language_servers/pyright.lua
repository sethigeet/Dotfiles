local LanguageServer = require("lsp.language_server")

local ls = LanguageServer:create({
  server_name = "pyright",
  formatters = "black",
  linters = "flake8",
  custom = {
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = "workspace",
        },
      },
    },
  },
  debugger_name = "python",
  -- debugger_config = {
  -- adapters = {},
  -- configurations = {},
  -- },
})

return ls
