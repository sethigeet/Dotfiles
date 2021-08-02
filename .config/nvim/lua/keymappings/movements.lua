local map = require("utils.map")

-- Better window movements
for _, mode in ipairs({ "n", "i", "x" }) do
  map.default_noremap(mode, "<M-h>", "<C-w>h")
  map.default_noremap(mode, "<M-j>", "<C-w>j")
  map.default_noremap(mode, "<M-k>", "<C-w>k")
  map.default_noremap(mode, "<M-l>", "<C-w>l")
end

-- Terminal window navigation
for _, mode in ipairs({ "t", "i" }) do
  map.default_noremap(mode, "<M-h>", [[<C-\><C-N><C-w>h]])
  map.default_noremap(mode, "<M-j>", [[<C-\><C-N><C-w>j]])
  map.default_noremap(mode, "<M-k>", [[<C-\><C-N><C-w>k]])
  map.default_noremap(mode, "<M-l>", [[<C-\><C-N><C-w>l]])
end

-- Use alt + left,down,up,right to resize windows
map.nnoremap("<M-K>", ":resize -2<CR>")
map.nnoremap("<M-J>", ":resize +2<CR>")
map.nnoremap("<M-H>", ":vertical resize -2<CR>")
map.nnoremap("<M-L>", ":vertical resize +2<CR>")

map.nnoremap("0", "getline('.')[0 : col('.') - 2] =~# '^\\s\\+$' ? '0' : '^'", { expr = true })
map.nnoremap("0", "getline('.')[0 : col('.') - 2] =~# '^\\s\\+$' ? '0' : '^'", { expr = true })

-- Fuzzy finder (requires telescope)
map.nnoremap("<C-p>", ":Telescope fzf_writer files<CR>")
map.nnoremap("<C-b>", ":Telescope buffers<CR>")
