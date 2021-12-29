vim.diagnostic.config({
  virtual_text = { spacing = 4, prefix = "" },
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = false,
  float = {
    show_header = true,
    border = "rounded",
  },
})

require("diagnostic.wrapper") 
