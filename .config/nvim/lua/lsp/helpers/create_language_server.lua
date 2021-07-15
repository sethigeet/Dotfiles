local LanguageServer = {
  lang = "",
  filetypes = {},
}

local function check_lsp_client_active(name)
  local clients = vim.lsp.get_active_clients()
  for _, client in pairs(clients) do
    if client.name == name then
      return true
    end
  end
  return false
end

function LanguageServer:create(o)
  o = o or {} -- create object if user does not provide one
  setmetatable(o, self)
  self.__index = self

  return o
end

function LanguageServer:lsp()
  if check_lsp_client_active(self.lang) then
    return
  end

  local options = {
    root_dir = require("lsp.helpers.root_dir"),
    on_attach = function(client, bufnr)
      require("lsp.helpers.document_highlight")(client)
      require("lsp.helpers.auto_format")(client)
      if self.on_attach then
        self.on_attach(client, bufnr)
      end
    end,
    handlers = {
      ["textDocument/publishDiagnostics"] = require("lsp.helpers.diagnostics_handler")(),
    },
  }

  if self.filetypes and #self.filetypes > 0 then
    options.filetypes = self.filetypes
  end

  if self.custom then
    for k, v in pairs(self.custom) do
      options[k] = v
    end
  end

  require("lspconfig")[self.lang].setup(options)
end

function LanguageServer:format() end

function LanguageServer:lint() end

function LanguageServer:debug() end

function LanguageServer:setup()
  self:lsp()
  self:lint()
  self:format()
  self:debug()
end

return LanguageServer
