local LanguageServer = require("lsp.helpers.language_server")

local ls = LanguageServer:create({
  server_name = "tsserver",
  formatters = "prettierd",
  linters = {
    "eslint",
    condition = function(utils)
      return utils.root_has_file(".eslintrc.json") or utils.root_has_file(".eslintrc.js")
    end,
  },
  on_attach = function(client, _)
    -- Disable formatting in the lsp server as `null-ls` handles formatting
    client.resolved_capabilities.document_formatting = false
  end,
})

return ls
