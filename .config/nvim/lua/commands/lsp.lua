vim.api.nvim_create_user_command(
  "ToggleInlayHints",
  function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = nil }), { bufnr = nil }) end,
  {
    desc = "Toggle the inlay hints in the current buffer",
  }
)
