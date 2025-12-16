local M = {}

function M.check_lsp_client_active(name)
  local active_clients = vim.lsp.get_clients()
  -- Check if a particular client is active
  if name then
    for _, client in pairs(active_clients) do
      if client.name == name then return true end
    end
    return false
  end

  -- Just check if any client is active
  if next(active_clients) == nil then return false end
  return true
end

function M.setup_keybindings(bufnr) require("keymappings.lsp").setup(bufnr) end

function M.setup_codelens(bufnr)
  require("utils.wrappers").define_augroups({
    lsp_codelens = {
      { "TextChanged,TextChangedI", string.format("<buffer=%d>", bufnr), cb = vim.lsp.codelens.refresh },
    },
  })

  -- TODO: Figure out a way to run this once the server has started
  -- vim.lsp.codelens.refresh()
end

function M.setup_inlay_hints(bufnr) vim.lsp.inlay_hint.enable(true, { bufnr = bufnr }) end

return M
