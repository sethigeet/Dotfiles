-- local custom_lsps = require("lsp.helpers.install_custom_lsp")
require("lsp.helpers.install_langserver")({
  "bash",
  "css",
  "dockerfile",
  "efm",
  "go",
  "graphql",
  "html",
  "json",
  "lua",
  "python",
  "typescript",
  "vim",
  "yaml",
})

require("lspinstall").setup()

require("lsp.language-servers.bash")
require("lsp.language-servers.css")
require("lsp.language-servers.docker")
require("lsp.language-servers.efm")
require("lsp.language-servers.go")
require("lsp.language-servers.graphql")
require("lsp.language-servers.html")
require("lsp.language-servers.json")
require("lsp.language-servers.lua")
require("lsp.language-servers.python")
require("lsp.language-servers.typescript")
require("lsp.language-servers.vim")
require("lsp.language-servers.yaml")
