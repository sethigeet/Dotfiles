local Plugin = require("plugins.plugin")

return Plugin:create({
  configure = function()
    vim.g["code#virtual_text_prefix"] = "❯ "
    vim.g["code#aliases"] = { ["javascript.jsx"] = "javascript" }
  end,

  highlight_groups = {
    { "CodiVirtualText", fg = "#6495ed" },
  },
})
