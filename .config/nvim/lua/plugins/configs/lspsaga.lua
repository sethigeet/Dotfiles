local plugin = {}

function plugin.setup()
  local saga = require("lspsaga")

  saga.init_lsp_saga(Opts.plugin.lspsaga.config)

  -- Show hover doc
  vim.api.nvim_set_keymap(
    "n",
    "K",
    "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>",
    { silent = true, noremap = true }
  )

  -- scroll down hover doc or scroll in definition preview
  vim.api.nvim_set_keymap(
    "n",
    "<C-f>",
    "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>",
    { silent = true, noremap = true }
  )

  -- scroll up hover doc
  vim.api.nvim_set_keymap(
    "n",
    "<C-b>",
    "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>",
    { silent = true, noremap = true }
  )

  -- signature
  vim.api.nvim_set_keymap(
    "n",
    "gs",
    "<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>",
    { silent = true, noremap = true }
  )
end

function plugin.config()
  Opts.plugin["lspsaga"] = {
    enabled = true,
    config = {
      border_style = "round",
    },
  }
end

return plugin
