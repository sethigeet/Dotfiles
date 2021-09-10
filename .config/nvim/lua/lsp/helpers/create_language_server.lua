local LanguageServer = {
  lang = "",
  cmd_args = {},
  filetypes = {},
  formatters = {},
  linters = {},
}

function LanguageServer:create(o)
  o = o or {} -- create object if user does not provide one
  setmetatable(o, self)
  self.__index = self

  return o
end

function LanguageServer:lsp()
  if require("lsp.helpers.check_lsp_active")(self.lang) then
    return
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

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

  local config = require("lspconfig")[self.lang]

  options.cmd = config.document_config.default_config.cmd
  -- Add custom args if specified
  if self.cmd_args and not vim.tbl_isempty(self.cmd_args) then
    for _, arg in ipairs(self.cmd_args) do
      table.insert(options.cmd, arg)
    end
  end

  config.setup(options)
end

local function formatForNullLS(builtins, customs)
  local function handleCustom(custom)
    if type(custom) == "string" and builtins[custom] then
      return builtins[custom]
    elseif type(custom) == "table" and builtins[custom[1]] then
      return builtins[custom[1]].with(custom)
    end
  end

  if type(customs) == "table" and not vim.tbl_isempty(customs) then
    if vim.tbl_islist(customs) then
      for i, custom in ipairs(customs) do
        customs[i] = handleCustom(custom)
      end
    else
      customs = { handleCustom(customs) }
    end
  elseif type(customs) == "string" and customs ~= "" then
    if builtins[customs] then
      customs = { builtins[customs] }
    end
  else
    customs = {}
  end

  return customs
end

function LanguageServer:format()
  local null_ls = require("null-ls")

  local formatters = formatForNullLS(null_ls.builtins.formatting, self.formatters)

  null_ls.register({ sources = formatters })
end

function LanguageServer:lint()
  local null_ls = require("null-ls")

  local linters = formatForNullLS(null_ls.builtins.diagnostics, self.linters)

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
