local function RootDir(filename)
    return vim.fn.getcwd()
end
-- require('lspconfig/util').root_pattern("files", ".git", ".")

return RootDir
