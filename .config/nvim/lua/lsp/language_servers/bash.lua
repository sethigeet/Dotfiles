local LanguageServer = require("lsp.helpers.create_language_server")

local ls = LanguageServer:create({
  lang = "bash",
  filetypes = { "sh", "bash", "zsh" },
  formatters = { "shfmt", args = { "-ci", "-i", "2", "-s", "-bn" } },
  linters = { "shellcheck", args = { "-e", "1090" } },
})

return ls
