local lsps = {}
for _, file in ipairs(vim.split(vim.fn.glob(CONFIG_PATH .. "/lua/lsp/language_servers/*"), "\n")) do
  local match = string.gmatch(file, [[[a-z,_,-]+.lua$]])()
  if match ~= "init.lua" then
    local name, _ = string.gsub(match, [[.lua$]], "", 1)
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
