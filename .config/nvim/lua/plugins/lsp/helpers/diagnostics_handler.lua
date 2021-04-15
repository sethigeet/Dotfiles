function DiagnosticsHandler(lang)
    return vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = Opts.lsp[lang].diagnostics.virtual_text,
        signs = Opts.lsp[lang].diagnostics.signs,
        underline = Opts.lsp[lang].diagnostics.underline,
        update_in_insert = true
    })
end

return DiagnosticsHandler

