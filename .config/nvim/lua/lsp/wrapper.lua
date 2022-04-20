-- Workspace folders
vim.api.nvim_create_user_command("LspAddWorkspaceFolder", function()
  vim.lsp.buf.add_workspace_folder()
end, { desc = "Add the current folder to the lsp workspace" })
vim.api.nvim_create_user_command("LspRemoveWorkspaceFolder", function()
  vim.lsp.buf.remove_workspace_folder()
end, { desc = "Remove the current folder from the lsp workspace" })
vim.api.nvim_create_user_command("LspListWorkspaceFolders", function()
  vim.lsp.buf.list_workspace_folders()
end, { desc = "List all the folders in the lsp workspace" })

-- References
vim.api.nvim_create_user_command("LspReferences", function()
  vim.lsp.buf.references()
  vim.lsp.buf.clear_references()
end, { desc = "Show the references using lsp" })
vim.api.nvim_create_user_command("LspClearReferences", function()
  vim.lsp.buf.clear_references()
end, { desc = "Clear all the references" })

-- Declaration/Definition/Implementation
vim.api.nvim_create_user_command("LspDeclaration", function()
  vim.lsp.buf.declaration()
end, { desc = "Go to the declaration using lsp" })
vim.api.nvim_create_user_command("LspDefinition", function()
  vim.lsp.buf.definition()
end, { desc = "Go to the definition using lsp" })
vim.api.nvim_create_user_command("LspImplementation", function()
  vim.lsp.buf.implementation()
end, { desc = "Go to the implementation using lsp" })

-- Calls
vim.api.nvim_create_user_command("LspIncomingCalls", function()
  vim.lsp.buf.incoming_calls()
end, { desc = "Show the incoming calls of the lsp client" })
vim.api.nvim_create_user_command("LspOutgoingCalls", function()
  vim.lsp.buf.outgoing_calls()
end, { desc = "Show the outgoing calls of the lsp client" })

-- Code Actions
vim.api.nvim_create_user_command("LspCodeActions", function()
  vim.lsp.buf.code_action()
end, { desc = "Show the available code actions" })
vim.api.nvim_create_user_command("LspRangeCodeActions", function()
  vim.lsp.buf.range_code_action()
end, { desc = "Show the available code actions in the selected range" })

-- Formatting
vim.api.nvim_create_user_command("LspFormatting", function()
  vim.lsp.buf.formatting()
end, { desc = "Format the document" })
vim.api.nvim_create_user_command("LspRangeFormatting", function()
  vim.lsp.buf.range_formatting()
end, { desc = "Format the selected range" })

-- Symbols
vim.api.nvim_create_user_command("LspWorkspaceSymbol", function()
  vim.lsp.buf.workspace_symbol()
end, { desc = "Show the workspace symbols" })
