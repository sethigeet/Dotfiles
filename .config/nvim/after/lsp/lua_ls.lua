---@type vim.lsp.Config
return {
  settings = {
    Lua = {
      type = {
        castNumberToInteger = true,
        inferParamType = true,
      },
      diagnostics = {
        -- Get the language server to recognize the global vars
        globals = {},
        unusedLocalExclude = { "_*" },
      },
      codeLens = {
        enable = true,
      },
      hint = {
        enable = true,
        arrayIndex = "Disable",
      },
      format = {
        enable = false,
      },
      workspace = {
        library = {},
        maxPreload = 100000,
        preloadFileSize = 100000,
      },
    },
  },
}
