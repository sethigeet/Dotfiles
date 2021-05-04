-- NOTE: This part uses the 'lsputil' plugin
vim.lsp.handlers["textDocument/codeAction"] = require("lsputil.codeAction").code_action_handler
vim.lsp.handlers["textDocument/references"] = require("lsputil.locations").references_handler
vim.lsp.handlers["textDocument/definition"] = require("lsputil.locations").definition_handler
vim.lsp.handlers["textDocument/declaration"] = require("lsputil.locations").declaration_handler
vim.lsp.handlers["textDocument/typeDefinition"] =
    require("lsputil.locations").typeDefinition_handler
vim.lsp.handlers["textDocument/implementation"] =
    require("lsputil.locations").implementation_handler
vim.lsp.handlers["textDocument/documentSymbol"] = require("lsputil.symbols").document_handler
vim.lsp.handlers["workspace/symbol"] = require("lsputil.symbols").workspace_handler
---------------------------------------------

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

-- Keymappings
vim.api.nvim_set_keymap("n", "gd", ":lua vim.lsp.buf.definition()<CR>",
                        { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-LeftMouse>", ":lua vim.lsp.buf.definition()<CR>",
                        { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gD", ":lua vim.lsp.buf.declaration()<CR>",
                        { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "gr", ":lua vim.lsp.buf.references()<CR>",
                        { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gi", ":lua vim.lsp.buf.implementation()<CR>",
                        { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "K", ":Lspsaga hover_doc<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-p>", ":Lspsaga diagnostic_jump_prev<CR>",
                        { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-n>", ":Lspsaga diagnostic_jump_next<CR>",
                        { noremap = true, silent = true })
-- scroll down hover doc or scroll in definition preview
vim.api.nvim_set_keymap("n", "<C-f>",
                        ":lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>",
                        { noremap = true, silent = true })
-- scroll up hover doc
vim.api.nvim_set_keymap("n", "<C-b>",
                        ":lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>",
                        { noremap = true, silent = true })

-- Automatically populate the location list with the lsp diagnostics
require("general.functions").define_augroups({
    lsp = { { "BufWrite,BufEnter,InsertLeave", "*", "LspPopulateLocationList" } }
})
