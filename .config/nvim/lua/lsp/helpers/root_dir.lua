local function root_dir(filename)
  return vim.fn.getcwd()
end
-- require('lspconfig/util').root_pattern("files", ".git", ".")

return root_dir
