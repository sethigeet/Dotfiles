local plugin = {}

function plugin.setup()
  vim.cmd("highlight CodiVirtualText guifg='#6495ed'")

  vim.cmd("let g:codi#virtual_text_prefix = '❯ '")

  vim.cmd("let g:codi#aliases = { 'javascript.jsx': 'javascript' }")
end

return plugin
