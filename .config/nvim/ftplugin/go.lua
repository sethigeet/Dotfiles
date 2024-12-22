-- Fix the keybinding overtaken by `vim-go` plugin
vim.keymap.set("n", "K", function() vim.lsp.buf.hover({ border = "rounded" }) end, { silent = true, buffer = true })
