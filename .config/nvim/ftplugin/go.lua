-- Fix the keybinding overtaken by `vim-go` plugin
vim.keymap.set("n", "K", vim.lsp.buf.hover, { silent = true, buffer = true })
