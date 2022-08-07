local lsps = {}
for _, file in ipairs(vim.api.nvim_get_runtime_file("lua/lsp/language_servers/*.lua", true)) do
  local name = vim.fn.fnamemodify(file, ":t:r")
  if name ~= "init" then table.insert(lsps, name) end
end

-- Setup lsp install
require("mason").setup({
  ui = {
    icons = {
      package_installed = "﫟",
      package_pending = "ﳁ",
      package_uninstalled = "",
    },
  },
})
require("mason-lspconfig").setup({ ensure_installed = lsps })

-- Load all the language servers
for _, lsp in ipairs(lsps) do
  require("lsp.language_servers." .. lsp):setup()
end
