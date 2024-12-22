require("utils.wrappers").highlight_groups({
  -- Git diff colors
  DiffAdd = { bg = "#283B4D" },
  DiffChange = { bg = "#283B4D" },
  DiffDelete = { bg = "#3C2C3C", fg = "#725272", bold = true },
  DiffText = { bg = "#365069" },

  -- Color for key pickers
  SelectNextKey = { fg = "#FF007C", bold = true },

  -- LSP colors
  LspReferenceText = { bg = "#464646" },
  LspReferenceRead = { bg = "#464646" },
  LspReferenceWrite = { bg = "#464646" },
})
