local lsps = {
  "bash",
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

-- Add the multi-purpose language server to the list
-- NOTE: This is not added before as this is not installed using `lspinstall`
-- It is a plugin directly installed in neovim using the plugin manager
-- table.insert(lsps, "null_ls")

-- Load all the language servers
for _, lsp in ipairs(lsps) do
  require("lsp.language_servers." .. lsp)
end

require("lsp.language_servers.null_ls")
