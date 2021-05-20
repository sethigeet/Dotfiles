local lspconfig = require("lspconfig")

-- Lua
local lua_format = require("lsp.language-servers.efm.lua-format")
-- Go
local golint = require("lsp.language-servers.efm.golint")
local gofmt = require("lsp.language-servers.efm.gofmt")
-- Python
local autopep8 = require("lsp.language-servers.efm.autopep8")
local pylint = require("lsp.language-servers.efm.pylint")
-- JavaScript/TypeScript
local eslint = require("lsp.language-servers.efm.eslint")
-- JavaScript/Flow/TypeScript/CSS/SCSS/Less/JSX/GraphQL/JSON/Markdown
local prettier = require("lsp.language-servers.efm.prettier")
-- Shell
local shellcheck = require("lsp.language-servers.efm.shellcheck")
local shfmt = require("lsp.language-servers.efm.shfmt")

lspconfig.efm.setup {
    init_options = {documentFormatting = true},
    filetypes = {
        "lua", "python", "typescript", "javascript", "typescriptreact",
        "javascriptreact", "yml", "yaml", "json", "html", "scss", "css",
        "markdown", "sh", "bash", "zsh"
    },
    root_dir = require("lsp.helpers.root_dir"),
    on_attach = function(client, bufnr)
        client.resolved_capabilities.document_formatting = true
        require("lsp.helpers.document_highlight")(client)
        require("lsp.helpers.auto_format")("efm_langserver", client)
    end,
    settings = {
        languages = {
            lua = {lua_format},
            go = {golint, gofmt},
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
        },
        log = DATA_PATH .. "/efm_langserver.log"
    }
}
