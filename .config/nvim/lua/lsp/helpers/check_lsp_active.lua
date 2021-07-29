local function check_lsp_client_active(name)
  local active_clients = vim.lsp.get_active_clients()
  -- Check if a particular client is active
  if name then
    for _, client in pairs(active_clients) do
      if client.name == name then
        return true
      end
    end
    return false
  end

  -- Just check if any client is active
  if next(active_clients) == nil then
    return false
  end
  return true
end

return check_lsp_client_active
