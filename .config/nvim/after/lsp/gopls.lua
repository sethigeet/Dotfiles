---@type vim.lsp.Config
return {
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
      gofumpt = false,
    },
  },
}
