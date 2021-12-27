local lsp_wrapper = {}

-- buffer
function lsp_wrapper.add_to_workspace_folder()
  vim.lsp.buf.add_workspace_folder()
end

function lsp_wrapper.clear_references()
  vim.lsp.buf.clear_references()
end

function lsp_wrapper.declaration()
  vim.lsp.buf.declaration()
  vim.lsp.buf.clear_references()
end

function lsp_wrapper.definition()
  vim.lsp.buf.definition()
  vim.lsp.buf.clear_references()
end

function lsp_wrapper.implementation()
  vim.lsp.buf.implementation()
end

function lsp_wrapper.incoming_calls()
  vim.lsp.buf.incoming_calls()
end

function lsp_wrapper.list_workspace_folders()
  vim.lsp.buf.list_workspace_folders()
end

function lsp_wrapper.outgoing_calls()
  vim.lsp.buf.outgoing_calls()
end

function lsp_wrapper.range_code_action()
  vim.lsp.buf.range_code_action()
end

function lsp_wrapper.range_formatting()
  vim.lsp.buf.range_formatting()
end

function lsp_wrapper.references()
  vim.lsp.buf.references()
  vim.lsp.buf.clear_references()
end

function lsp_wrapper.remove_workspace_folder()
  vim.lsp.buf.remove_workspace_folder()
end

function lsp_wrapper.workspace_symbol()
  vim.lsp.buf.workspace_symbol()
end

return lsp_wrapper
