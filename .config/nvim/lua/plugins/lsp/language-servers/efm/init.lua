local lspconfig = require("lspconfig")

-- Lua
local lua_format = require("plugins.lsp.language-servers.efm.lua-format")
-- Go
local golint = require("plugins.lsp.language-servers.efm.golint")
local goimports = require("plugins.lsp.language-servers.efm.goimports")
-- Python
local autopep8 = require("plugins.lsp.language-servers.efm.autopep8")
local pylint = require("plugins.lsp.language-servers.efm.pylint")
-- JavaScript/TypeScript
local eslint = require("plugins.lsp.language-servers.efm.eslint")
-- JavaScript/Flow/TypeScript/CSS/SCSS/Less/JSX/GraphQL/JSON/Markdown
local prettier = require("plugins.lsp.language-servers.efm.prettier")
-- Shell
local shellcheck = require("plugins.lsp.language-servers.efm.shellcheck")
local shfmt = require("plugins.lsp.language-servers.efm.shfmt")

lspconfig.efm.setup {
    init_options = {documentFormatting = true},
    filetypes = {
        "lua", "go", "python", "typescript", "javascript", "typescriptreact", "javascriptreact",
        "yml", "yaml", "json", "html", "scss", "css", "markdown", "sh", "bash", "zsh"
    },
    root_dir = require("plugins.lsp.helpers.root_dir"),
    on_attach = function(client, bufnr)
        client.resolved_capabilities.document_formatting = true
        require("plugins.lsp.helpers.document_highlight")(client)
        require("plugins.lsp.helpers.auto_format")(client, bufnr)
    end,
    settings = {
        languages = {
            lua = {lua_format},
            go = {golint, goimports},
            python = {autopep8, pylint},
            typescript = {prettier, eslint},
            javascript = {prettier, eslint},
            typescriptreact = {prettier, eslint},
            javascriptreact = {prettier, eslint},
            yaml = {prettier},
            yml = {prettier},
            json = {prettier},
            html = {prettier},
            scss = {prettier},
            css = {prettier},
            markdown = {prettier},
            sh = {shellcheck, shfmt},
            bash = {shellcheck, shfmt},
            zsh = {shellcheck, shfmt}
        }
    }
}
