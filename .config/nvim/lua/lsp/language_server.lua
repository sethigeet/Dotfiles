local LanguageServer = {
  -- For lsp
  server_name = "",
  cmd_args = {},
  capabilities = {},
  filetypes = {},

  -- For `nvim-dap`
  debugger_name = "",
  debugger_config = {},

  -- For null-ls
  formatters = {},
  linters = {},
  code_actions = {},

  -- For asthetics
  virtual_text = {
    inlay_hints = false,
    code_lens = false,
    dim_unused = true,
  },
}

local lsp_utils = require("utils.lsp")

function LanguageServer:create(o)
  o = o or {} -- create object if user does not provide one
  setmetatable(o, self)
  self.__index = self

  return o
end

function LanguageServer:lsp()
  if lsp_utils.check_lsp_client_active(self.server_name) then
    return
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities = vim.tbl_deep_extend("force", capabilities, self.capabilities)
  capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

  local options = {
    root_dir = lsp_utils.get_root_dir,
    on_attach = function(client, bufnr)
      if self.on_attach then
        self.on_attach(client, bufnr)
      end

      lsp_utils.setup_document_highlight(client)
      lsp_utils.setup_format_on_save(client)
      lsp_utils.setup_keybindings(bufnr)

      if self.virtual_text.inlay_hints then
        -- NOTE: This currently only supports `rust-analyzer`
        lsp_utils.setup_inlay_hints()
      end

      if self.virtual_text.code_lens then
        lsp_utils.setup_codelens()
      end

      if self.virtual_text.dim_unused then
        lsp_utils.setup_dim_unused()
      end
    end,
    capabilities = capabilities,
  }

  if self.filetypes and #self.filetypes > 0 then
    options.filetypes = self.filetypes
  end

  if self.custom then
    options = vim.tbl_deep_extend("force", options, self.custom)
  end

  if self.server_name == "null-ls" then
    require("null-ls").setup(options)
    return
  end

  local lsp_installer_servers = require("nvim-lsp-installer.servers")
  local ok, server = lsp_installer_servers.get_server(self.server_name)
  if not ok then
    require("lspconfig")[self.server_name].setup(options)
    return
  end

  -- Install the server if it is not installed
  if not server:is_installed() then
    server:install()
  end

  -- Add custom args if specified
  if self.cmd_args and not vim.tbl_isempty(self.cmd_args) then
    local cmd = server._default_options.cmd
      or require("lspconfig.server_configurations." .. self.server_name).default_config.cmd
    for _, arg in ipairs(self.cmd_args) do
      table.insert(cmd, arg)
    end
  end

  server:setup(options)
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

function LanguageServer:setup_formatters()
  local null_ls = require("null-ls")

  local formatters = formatForNullLS(null_ls.builtins.formatting, self.formatters)

  null_ls.register(formatters)
end

function LanguageServer:setup_linters()
  local null_ls = require("null-ls")

  local linters = formatForNullLS(null_ls.builtins.diagnostics, self.linters)

  null_ls.register(linters)
end

function LanguageServer:setup_code_actions()
  local null_ls = require("null-ls")

  local code_actions = formatForNullLS(null_ls.builtins.code_actions, self.code_actions)

  null_ls.register(code_actions)
end

function LanguageServer:debug()
  if self.debugger_name == "" then
    return
  end

  local dap_install = require("dap-install")
  local installed_debuggers = require("dap-install.api.debuggers").get_installed_debuggers()

  -- If the debugger is not installed, then install it
  if not vim.tbl_contains(installed_debuggers, self.debugger_name) then
    require("dap-install.core.install").install_debugger(self.debugger_name)
  end

  dap_install.config(self.debugger_name, self.debugger_config)
end

function LanguageServer:setup()
  self:setup_code_actions()
  self:lsp()
  self:setup_linters()
  self:setup_formatters()
  self:debug()
end

return LanguageServer
