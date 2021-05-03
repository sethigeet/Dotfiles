-- Global Leader key
vim.g.mapleader = " "
-- let localLeader=" "
vim.api.nvim_set_keymap("n", "<Space>", "<NOP>", { noremap = true, silent = true })

-- Fixed the "Y" behavior
vim.api.nvim_set_keymap("n", "Y", "y$", { noremap = true, silent = true })

-- TAB in general mode will move to text buffer
vim.api.nvim_set_keymap("n", "<TAB>", ":bnext<CR>", { noremap = true, silent = true })
-- SHIFT-TAB will go back
vim.api.nvim_set_keymap("n", "<S-TAB>", ":bprevious<CR>", { noremap = true, silent = true })

-- Move selected line / block of text in visual mode
vim.api.nvim_set_keymap("x", "K", ":move '<-2<CR>gv-gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "J", ":move '>+1<CR>gv-gv", { noremap = true, silent = true })

-- Alternate way to save
vim.api.nvim_set_keymap("n", "<C-s>", ":w<CR>", { noremap = true, silent = true })

-- <TAB>: completion.
vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.smart_tab()",
                        { silent = true, expr = true, noremap = true })
