local lsps = {
  "bash",
  "cpp",
  "css",
  "dockerfile",
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

-- Setup lsp install
require("lspinstall").setup()

-- Load all the language servers
for _, lsp in ipairs(lsps) do
  require("lsp.language_servers." .. lsp):setup()
end

require("lsp.language_servers.null_ls"):setup()
