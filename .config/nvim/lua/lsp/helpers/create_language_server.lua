local LanguageServer = {
  lang = "",
  filetypes = {},
  formatters = {},
  linters = {},
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

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  local options = {
    root_dir = require("lsp.helpers.root_dir"),
    on_attach = function(client, bufnr)
      require("lsp.helpers.document_highlight")(client)
      require("lsp.helpers.format_on_save")(client)
      if self.on_attach then
        self.on_attach(client, bufnr)
      end
    end,
    capabilities = capabilities,
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

function LanguageServer:format()
  local formatters = self.formatters

  local null_ls = require("null-ls")
  local builtin_formatters = null_ls.builtins.formatting

  if type(formatters) == "table" and not vim.tbl_isempty(formatters) and vim.tbl_islist(formatters) then
    for i, formatter in ipairs(formatters) do
      if builtin_formatters[formatter] then
        formatters[i] = builtin_formatters[formatter]
      end
    end
  elseif type(formatters) == "string" and formatters ~= "" then
    if builtin_formatters[formatters] then
      formatters = { builtin_formatters[formatters] }
    end
  else
    formatters = {}
  end

  null_ls.register({ sources = formatters })
end

function LanguageServer:lint()
  local linters = self.linters

  local null_ls = require("null-ls")
  local builtin_linters = null_ls.builtins.diagnostics

  if type(linters) == "table" and not vim.tbl_isempty(linters) and vim.tbl_islist(linters) then
    for i, linter in ipairs(linters) do
      if builtin_linters[linter] then
        linters[i] = builtin_linters[linter]
      end
    end
  elseif type(linters) == "string" and linters ~= "" then
    if builtin_linters[linters] then
      linters = { builtin_linters[linters] }
    end
  else
    linters = {}
  end

  null_ls.register({ sources = linters })
end

function LanguageServer:debug() end

function LanguageServer:setup()
  self:lsp()
  self:lint()
  self:format()
  self:debug()
end

return LanguageServer
