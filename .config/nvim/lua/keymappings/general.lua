local map = require("utils.wrappers").map

-- Global Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
map("n", "<Space>", "<NOP>")
map("n", "\\", "<NOP>")

-- Easily duplicate lines
map("n", "yp", "yyp")

-- Easily delete words in insert mode
map("i", "<C-BS>", "<C-W>")

-- TAB in general mode will move to text buffer
map("n", "<TAB>", "<Cmd>bnext<CR>")
-- SHIFT-TAB will go back
map("n", "<S-TAB>", "<Cmd>bprevious<CR>")
-- Shift-x will close the buffer
map("n", "X", "<Cmd>bdelete<CR>")

-- Move selected line / block of text in visual mode
map("x", "K", ":move '<-2<CR>gv-gv")
map("x", "J", ":move '>+1<CR>gv-gv")

-- Alternate way to save
map("n", "<C-s>", "<Cmd>w<CR>")
map("n", "<M-s>", "<Cmd>w<CR>")

-- Get rid of highlights easily
map("n", "<M-Esc>", "<cmd>nohl<CR>")
