-- Get diagnostic
vim.api.nvim_create_user_command("DiagnosticGetAll", function()
  vim.diagnostic.get()
end, { desc = "Get all the available diagnostics" })
vim.api.nvim_create_user_command("DiagnosticGetNext", function()
  vim.diagnostic.get_next()
end, { desc = "Get the next diagnostic" })
vim.api.nvim_create_user_command("DiagnosticGetPrev", function()
  vim.diagnostic.get_prev()
end, { desc = "Get the previous diagnostic" })

-- Goto diagnostic
vim.api.nvim_create_user_command("DiagnosticGotoNext", function()
  vim.diagnostic.goto_next()
end, { desc = "Go to the next diagnostic" })
vim.api.nvim_create_user_command("DiagnosticGotoPrev", function()
  vim.diagnostic.goto_prev()
end, { desc = "Go to the previous diagnostic" })

-- Location list
vim.api.nvim_create_user_command("DiagnosticPopulateLocList", function()
  vim.diagnostic.set_loclist({ open_loclist = false })
end, { desc = "Populate the location list with the available diagnostics" })

-- Virtual text
local show_virtual_text = true
vim.api.nvim_create_user_command("DiagnosticToggleVirtualText", function()
  show_virtual_text = not show_virtual_text

  vim.diagnostic.config({
    virtual_text = show_virtual_text and { spacing = 4, prefix = "" } or false,
  })
end, { desc = "Toggle the virtual text showing the diagnostics" })
