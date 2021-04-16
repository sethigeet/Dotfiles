local custom_lsps = require("plugins.lsp.helpers.install_custom_lsp")
custom_lsps.Emmet()

require("plugins.lsp.helpers.install_langserver")({
    "bash", "css", "dockerfile", "efm", "emmet", "go", "graphql", "html", "json", "lua", "python",
    "typescript", "vim", "yaml"
})

require("lspinstall").setup()

require("plugins.lsp.language-servers.bash")
require("plugins.lsp.language-servers.css")
require("plugins.lsp.language-servers.docker")
require("plugins.lsp.language-servers.efm")
require("plugins.lsp.language-servers.emmet")
require("plugins.lsp.language-servers.go")
require("plugins.lsp.language-servers.graphql")
require("plugins.lsp.language-servers.html")
require("plugins.lsp.language-servers.json")
require("plugins.lsp.language-servers.lua")
require("plugins.lsp.language-servers.python")
require("plugins.lsp.language-servers.typescript")
require("plugins.lsp.language-servers.vim")
require("plugins.lsp.language-servers.yaml")
