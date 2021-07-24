-- Fix the keybinding overtaken by `vim-go` plugin
vim.api.nvim_buf_set_keymap(0, "n", "K", ":lua vim.lsp.buf.hover()<cr>", { silent = true, noremap = true })
