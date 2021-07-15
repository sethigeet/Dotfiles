-- Fix the keybinging overtaken by `vim-go` plugin
vim.api.nvim_buf_set_keymap(0, "n", "K", ":Lspsaga hover_doc<cr>", { silent = true, noremap = true })
