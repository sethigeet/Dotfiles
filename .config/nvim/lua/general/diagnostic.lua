local icons = {
  Error = "",
  Warn = "",
  Hint = "",
  Info = "",
}

vim.diagnostic.config({
  virtual_text = {
    spacing = 4,
    prefix = function(diagnostic)
      for d, icon in pairs(icons) do
        if diagnostic.severity == vim.diagnostic.severity[d:upper()] then return icon end
      end
      return "●"
    end,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = icons.Error,
      [vim.diagnostic.severity.WARN] = icons.Warn,
      [vim.diagnostic.severity.HINT] = icons.Hint,
      [vim.diagnostic.severity.INFO] = icons.Info,
    },
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    show_header = true,
    border = "rounded",
  },
})

-- Custom wrapper commands
-- Goto diagnostic
vim.api.nvim_create_user_command(
  "DiagnosticGotoNext",
  function() vim.diagnostic.jump({ count = 1, float = true }) end,
  { desc = "Go to the next diagnostic" }
)
vim.api.nvim_create_user_command(
  "DiagnosticGotoPrev",
  function() vim.diagnostic.jump({ count = -1, float = true }) end,
  { desc = "Go to the previous diagnostic" }
)

-- Location list
vim.api.nvim_create_user_command(
  "DiagnosticPopulateLocList",
  function() vim.diagnostic.set_loclist({ open_loclist = false }) end,
  { desc = "Populate the location list with the available diagnostics" }
)

-- Virtual text
local show_virtual_text = true
vim.api.nvim_create_user_command("DiagnosticToggleVirtualText", function()
  show_virtual_text = not show_virtual_text

  vim.diagnostic.config({
    virtual_text = show_virtual_text and { spacing = 4, prefix = "" } or false,
  })
end, { desc = "Toggle the virtual text showing the diagnostics" })
