local lspconfig = require("lspconfig")

local lua_format = require("plugins.lsp.language-servers.efm.lua-format")
local golint = require("plugins.lsp.language-servers.efm.golint")
local goimports = require("plugins.lsp.language-servers.efm.goimports")
local black = require("plugins.lsp.language-servers.efm.black")
local flake8 = require("plugins.lsp.language-servers.efm.flake8")
local prettier = require("plugins.lsp.language-servers.efm.prettier")
local eslint = require("plugins.lsp.language-servers.efm.eslint")

lspconfig.efm.setup {
    init_options = {documentFormatting = true},
    filetypes = {
        "lua", "go", "python", "typescript", "javascript", "typescriptreact",
        "javascriptreact", "yaml", "json", "html", "scss", "css", "markdown"
    },
    root_dir = function() return vim.fn.getcwd() end,
    on_attach = function(client, bufnr)
        client.resolved_capabilities.document_formatting = true
        require("plugins.lsp.helpers.document_highlight")(client)
        require("plugins.lsp.helpers.auto_format")(client, bufnr)
    end,
    settings = {
        languages = {
            lua = {lua_format},
            go = {golint, goimports},
            python = {black, flake8},
            typescript = {prettier, eslint},
            javascript = {prettier, eslint},
            typescriptreact = {prettier, eslint},
            javascriptreact = {prettier, eslint},
            yaml = {prettier},
            json = {prettier},
            html = {prettier},
            scss = {prettier},
            css = {prettier},
            markdown = {prettier}
        }
    }
}
