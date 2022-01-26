local lsps = {}
for _, file in ipairs(vim.api.nvim_get_runtime_file("lua/lsp/language_servers/*.lua", true)) do
  local name = vim.fn.fnamemodify(file, ":t:r")
  if name ~= "init" then
    table.insert(lsps, name)
  end
end

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
