local function AutoFormat(lang, client)
  if client.resolved_capabilities.document_formatting then
    vim.cmd("augroup Format")
    vim.cmd("autocmd! * <buffer>")
    vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting()")
    vim.cmd("augroup END")
  end
end

return AutoFormat
