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

  formatting = false,

  debugger_name = "go_delve",
  -- debugger_config = {
  -- adapters = {},
  -- configurations = {},
  -- },
})

return ls
