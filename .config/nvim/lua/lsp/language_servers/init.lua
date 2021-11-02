local lsps = {
  "bashls",
  "clangd",
  "cssls",
  "dockerls",
  "gopls",
  "graphql",
  "html",
  "jsonls",
  "sumneko_lua",
  "pyright",
  "tsserver",
  "vimls",
  "yamlls",
}

-- Setup lsp install
local lsp_installer = require("nvim-lsp-installer")
lsp_installer.settings({})
lsp_installer.on_server_ready(function(_)
  vim.cmd([[ do User LspAttachBuffers ]])
end)

-- Load all the language servers
for _, lsp in ipairs(lsps) do
  require("lsp.language_servers." .. lsp):setup()
end

require("lsp.language_servers.null_ls"):setup()
