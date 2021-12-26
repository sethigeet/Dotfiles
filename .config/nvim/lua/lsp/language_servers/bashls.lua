local LanguageServer = require("lsp.language_server")

local ls = LanguageServer:create({
  server_name = "bashls",
  filetypes = { "sh", "bash", "zsh" },
  formatters = { "shfmt", extra_args = { "-ci", "-i", "2", "-s", "-bn" } },
  linters = { "shellcheck", extra_args = { "-e", "1090" } },
})

return ls
