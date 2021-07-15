-- Lua
local stylua = require("lsp.language_servers.efm.stylua")
-- Go
local golint = require("lsp.language_servers.efm.golint")
local gofmt = require("lsp.language_servers.efm.gofmt")
-- Python
local autopep8 = require("lsp.language_servers.efm.autopep8")
local pylint = require("lsp.language_servers.efm.pylint")
-- JavaScript/TypeScript
local eslint = require("lsp.language_servers.efm.eslint")
-- JavaScript/Flow/TypeScript/CSS/SCSS/Less/JSX/GraphQL/JSON/Markdown
local prettier = require("lsp.language_servers.efm.prettier")
-- Shell
local shellcheck = require("lsp.language_servers.efm.shellcheck")
local shfmt = require("lsp.language_servers.efm.shfmt")

local LanguageServer = require("lsp.helpers.create_language_server")

local ls = LanguageServer:create({
  lang = "efm",
  filetypes = {
    "lua",
    "python",
    "typescript",
    "javascript",
    "typescriptreact",
    "javascriptreact",
    "yml",
    "yaml",
    "json",
    "html",
    "scss",
    "css",
    "markdown",
    "sh",
    "bash",
    "zsh",
  },
  on_attach = function(client, _)
    client.resolved_capabilities.document_formatting = true
  end,
  custom = {
    init_options = { documentFormatting = true },
    settings = {
      languages = {
        lua = { stylua },
        go = { golint, gofmt },
        python = { autopep8, pylint },
        typescript = { prettier, eslint },
        javascript = { prettier, eslint },
        typescriptreact = { prettier, eslint },
        javascriptreact = { prettier, eslint },
        yaml = { prettier },
        yml = { prettier },
        json = { prettier },
        html = { prettier },
        scss = { prettier },
        css = { prettier },
        markdown = { prettier },
        sh = { shellcheck, shfmt },
        bash = { shellcheck, shfmt },
        zsh = { shellcheck, shfmt },
      },
      log = DATA_PATH .. "/efm_langserver.log",
    },
  },
})

ls:setup()
