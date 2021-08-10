local LanguageServer = require("lsp.helpers.create_language_server")

local ls = LanguageServer:create({
  lang = "cpp",
  -- NOTE: The formatting is also handled by `clangd`
  formatters = "clang_format",
  cmd_args = { "--clang-tidy", "--cross-file-rename" },
  on_attach = function(client, _)
    -- Disable formatting in the lsp server as `null-ls` handles formatting
    client.resolved_capabilities.document_formatting = false
  end,
})

return ls
