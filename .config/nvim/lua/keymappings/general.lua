local map = require("utils.map")

-- Global Leader key
vim.g.mapleader = " "
-- let localLeader=" "
map.nnoremap("<Space>", "<NOP>")

-- Easily duplicate lines
map.nnoremap("yp", "yyp")

-- Easily delete words in insert mode
map.inoremap("<C-BS>", "<C-W>")

-- TAB in general mode will move to text buffer
map.nnoremap("<TAB>", "<cmd>bnext<CR>")
-- SHIFT-TAB will go back
map.nnoremap("<S-TAB>", "<cmd>bprevious<CR>")
-- Shift-x will close the buffer
map.nnoremap("X", "<cmd>bdelete<CR>")

-- Move selected line / block of text in visual mode
map.xnoremap("K", ":move '<-2<CR>gv-gv")
map.xnoremap("J", ":move '>+1<CR>gv-gv")

-- Alternate way to save
map.nnoremap("<C-s>", ":w<CR>")

-- Get rid of highlights easily
map.nnoremap("<M-Esc>", "<cmd>nohl<CR>")
