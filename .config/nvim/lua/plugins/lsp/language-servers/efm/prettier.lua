return {
    formatCommand = (require("plugins.lsp.helpers.get_language_server_path")("prettier", "prettier",
                                                                             "node") .. [[
        ${--config-precedence:configPrecedence}
        ${--tab-width:tabWidth}
        ${--single-quote:singleQuote}
        ${--trailing-comma:trailingComma}
    ]]):gsub("\n", "")
}
