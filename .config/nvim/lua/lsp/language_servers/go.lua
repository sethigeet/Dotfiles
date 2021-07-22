local LanguageServer = require("lsp.helpers.create_language_server")

local ls = LanguageServer:create({
  lang = "go",
  custom = {
    settings = { gopls = { analyses = { unusedparams = true }, staticcheck = true } },
    init_options = { usePlaceholders = true },
    gopls = {
      analyses = { unusedparams = true, unreachable = false },
      codelenses = {
        generate = true, -- show the `go generate` lens.
        gc_details = true, -- Show a code lens toggling the display of gc's choices.
      },
      usePlaceholders = true,
      completeUnimported = true,
      staticcheck = true,
      matcher = "fuzzy",
      symbolMatcher = "fuzzy",
      gofumpt = false, -- turn on for new repos, gofumpt is good but also create code turmoils
    },
  },
})

ls:setup()
