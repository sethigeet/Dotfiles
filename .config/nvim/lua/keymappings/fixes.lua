local map = require("utils").map

-- Saner "n" and "N" behavior
-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map({ "n", "x", "o" }, "n", "'Nn'[v:searchforward]", { expr = true })
map({ "n", "x", "o" }, "N", "'nN'[v:searchforward]", { expr = true })

-- Make <number>j/k register in jumplist too (only when <number> > 5)
map("n", "j", [[(v:count > 5 ? "m'" . v:count : "") . "j"]], { expr = true })
map("n", "k", [[(v:count > 5 ? "m'" . v:count : "") . "k"]], { expr = true })

-- Add more undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- make * and # work in visual mode too!
vim.api.nvim_exec(
  [[
  function! g:VSetSearch(cmdtype)
    let temp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
    let @s = temp
  endfunction
  xnoremap * :<C-u>call g:VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
  xnoremap # :<C-u>call g:VSetSearch('?')<CR>?<C-R>=@/<CR><CR>
]],
  false
)
