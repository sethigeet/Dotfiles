function AutoFormat(client, bufnr)
    vim.cmd("augroup Format")
    vim.cmd("autocmd! * <buffer>")
    vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting()")
    vim.cmd("augroup END")
end

return AutoFormat
