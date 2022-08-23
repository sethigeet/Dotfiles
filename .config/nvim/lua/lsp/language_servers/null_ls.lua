-- Setup null-ls with custom lsp wrapper
local LanguageServer = require("lsp.language_server")

local ls = LanguageServer:create({
  server_name = "null-ls",

  formatters = {
    {
      "sql_formatter",
      extra_args = { "-l", "postgresql", "--config", vim.env.XDG_CONFIG_HOME .. "/sql-formatter/config.json" },
    },
  },

  virtual_text = {
    inlay_hints = false,
    code_lens = false,
    dim_unused = false,
  },
})

return ls
