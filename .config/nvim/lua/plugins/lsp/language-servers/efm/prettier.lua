return {
    formatCommand = require("plugins.lsp.helpers.get_language_server_path")("prettier",
                                                                            "prettier --stdin-filepath '${INPUT}'",
                                                                            "node"),
    formatStdin = true
}
