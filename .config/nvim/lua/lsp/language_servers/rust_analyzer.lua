local LanguageServer = require("lsp.language_server")

local ls = LanguageServer:create({
  server_name = "rust_analyzer",

  capabilities = {
    experimental = {
      serverStatusNotification = true,
      snippetTextEdit = true,
      codeActionGroup = true,
    },

    -- enable auto-import
    textDocument = {
      completion = {
        completionItem = {
          resolveSupport = {
            properties = { "documentation", "detail", "additionalTextEdits" },
          },
        },
      },
    },
  },

  on_attach = function(_, _)
    require("lsp.helpers.inlay_hints").setup_autocmd()
  end,

  -- TODO: Setup the functionality for the debugger
  -- debugger_name = "",
  -- debugger_config = {
  -- adapters = {},
  -- configurations = {},
  -- },
})

return ls
