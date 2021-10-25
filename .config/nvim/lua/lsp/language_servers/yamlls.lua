local LanguageServer = require("lsp.helpers.language_server")

local ls = LanguageServer:create({
  server_name = "yamlls",
  formatters = "prettierd",
  custom = {
    settings = {
      yaml = {
        hover = true,
        completion = true,
        validate = true,
        schemaStore = {
          enable = true,
          url = "https://www.schemastore.org/api/json/catalog.json",
        },
        schemas = {
          kubernetes = {
            "daemon.{yml,yaml}",
            "manager.{yml,yaml}",
            "restapi.{yml,yaml}",
            "role.{yml,yaml}",
            "role_binding.{yml,yaml}",
            "*onfigma*.{yml,yaml}",
            "*ngres*.{yml,yaml}",
            "*ecre*.{yml,yaml}",
            "*eployment*.{yml,yaml}",
            "*ervic*.{yml,yaml}",
            "kubectl-edit*.yaml",
          },
        },
      },
    },
  },
})

return ls
