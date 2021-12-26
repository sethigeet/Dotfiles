local LanguageServer = require("lsp.language_server")

local ls = LanguageServer:create({
  server_name = "gopls",
  custom = {
    settings = {
      gopls = {
        analyses = { unusedparams = true },
        staticcheck = true,
        codelenses = {
          generate = true, -- show the `go generate` lens.
          gc_details = true, -- Show a code lens toggling the display of gc's choices.
        },
        usePlaceholders = true,
        completeUnimported = true,
        matcher = "fuzzy",
        symbolMatcher = "fuzzy",
        gofumpt = false, -- turn on for new repos, gofumpt is good but also create code turmoils
      },
    },
    init_options = { usePlaceholders = true },
  },
  on_attach = function(client, _)
    -- Disable formatting in the lsp server as `vim-go` plugin handles formatting
    client.resolved_capabilities.document_formatting = false
  end,
})

return ls
