local function check_lsp_active()
  local active_clients = vim.lsp.get_active_clients()
  if next(active_clients) == nil then
    return false
  end
  return true
end

return check_lsp_active
