local lsps = {
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
}

-- Setup automatic lsp install
require("lsp.helpers.install_langservers")(lsps)

require("lspinstall").setup()

for _, lsp in ipairs(lsps) do
  require("lsp.language_servers." .. lsp)
end
