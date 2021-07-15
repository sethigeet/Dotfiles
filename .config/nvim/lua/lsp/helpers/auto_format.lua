local function AutoFormat(client)
  if Opts.editor.format_on_save and client.resolved_capabilities.document_formatting then
    vim.cmd("augroup Format")
    vim.cmd("autocmd! * <buffer>")
    vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting()")
    vim.cmd("augroup END")
  end
end

return AutoFormat
