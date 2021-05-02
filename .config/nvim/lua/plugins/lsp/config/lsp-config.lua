-- Colors for diagnostics
vim.fn.sign_define("LspDiagnosticsDefaultError",
                   { texthl = "LspDiagnosticsDefaultError", numhl = "LspDiagnosticsDefaultError" })
vim.fn.sign_define("LspDiagnosticsDefaultWarning", {
    texthl = "LspDiagnosticsDefaultWarning",
    numhl = "LspDiagnosticsDefaultWarning"
})
vim.fn.sign_define("LspDiagnosticsDefaultInformation", {
    texthl = "LspDiagnosticsDefaultInformation",
    numhl = "LspDiagnosticsDefaultInformation"
})
vim.fn.sign_define("LspDiagnosticsDefaultHint",
                   { texthl = "LspDiagnosticsDefaultHint", numhl = "LspDiagnosticsDefaultHint" })

-- Signs for diagnostics
vim.fn.sign_define("LspDiagnosticsSignError", {
    texthl = "LspDiagnosticsSignError",
    text = "",
    numhl = "LspDiagnosticsSignError"
})
vim.fn.sign_define("LspDiagnosticsSignWarning", {
    texthl = "LspDiagnosticsSignWarning",
    text = "",
    numhl = "LspDiagnosticsSignWarning"
})
vim.fn.sign_define("LspDiagnosticsSignInformation", {
    texthl = "LspDiagnosticsSignInformation",
    text = "",
    numhl = "LspDiagnosticsSignInformation"
})
vim.fn.sign_define("LspDiagnosticsSignHint", {
    texthl = "LspDiagnosticsSignHint",
    text = "",
    numhl = "LspDiagnosticsSignHint"
})

-- Symbols for autocomplete
vim.lsp.protocol.CompletionItemKind = {
    "  ", -- Text
    "  ", -- Method
    "  ", -- Function
    "  ", -- Constructor
    " ﴲ ", -- Field
    "[]", -- Variable
    "  ", -- Class
    " ﰮ ", -- Interface
    "  ", -- Module
    " 襁", -- Property
    " 塞", -- Unit
    "  ", -- Value
    " 練", -- Enum
    "  ", -- Keyword
    "  ", -- Snippet
    "  ", -- Color
    "  ", -- File
    "  ", -- Reference
    "  ", -- Folder
    "  ", -- EnumMember
    " ﲀ ", -- Constant
    "  ", -- Struct
    "  ", -- Event
    "  ", -- Operator
    "  " -- TypeParameter
}

vim.cmd("nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>")
vim.cmd("nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>")
vim.cmd("nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>")
vim.cmd("nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>")
vim.cmd("nnoremap <silent> ca :Lspsaga code_action<CR>")
vim.cmd("nnoremap <silent> K :Lspsaga hover_doc<CR>")
-- vim.cmd('nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>')
vim.cmd("nnoremap <silent> <C-p> :Lspsaga diagnostic_jump_prev<CR>")
vim.cmd("nnoremap <silent> <C-n> :Lspsaga diagnostic_jump_next<CR>")
-- scroll down hover doc or scroll in definition preview
vim.cmd("nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>")
-- scroll up hover doc
vim.cmd("nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>")
