local LanguageServer = require("lsp.language_server")

local ls = LanguageServer:create({
  server_name = "clangd",
  -- NOTE: The formatting is also handled by `clangd`
  formatters = "clang_format",
  cmd_args = { "--clang-tidy", "--cross-file-rename" },
  on_attach = function(client, _)
    -- Disable formatting in the lsp server as `null-ls` handles formatting
    client.resolved_capabilities.document_formatting = false
  end,

  debugger_name = "ccppr_vsc",
  -- debugger_config = {
  -- adapters = {},
  -- configurations = {},
  -- },
})

return ls
