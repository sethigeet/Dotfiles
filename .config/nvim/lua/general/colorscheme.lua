local highlight_groups = require("utils.wrappers").highlight_groups

-- Git diff colors
highlight_groups({
  DiffAdd = { bg = "#283B4D" },
  DiffChange = { bg = "#283B4D" },
  DiffDelete = { bg = "#3C2C3C", fg = "#725272", style = "bold" },
  DiffText = { bg = "#365069" },
  SelectNextKey = { fg = "#FF007C", style = "bold" },
})
