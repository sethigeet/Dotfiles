local map = require("utils.map")

-- Fix the "Y" behavior
map.nnoremap("Y", "y$")

-- Saner "n" and "N" behavior
-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map.nnoremap("n", "'Nn'[v:searchforward]", { expr = true })
map.xnoremap("n", "'Nn'[v:searchforward]", { expr = true })
map.onoremap("n", "'Nn'[v:searchforward]", { expr = true })
map.nnoremap("N", "'nN'[v:searchforward]", { expr = true })
map.xnoremap("N", "'nN'[v:searchforward]", { expr = true })
map.onoremap("N", "'nN'[v:searchforward]", { expr = true })

-- Make <number>j/k register in jumplist too (only when <number> > 5)
map.nnoremap("j", [[(v:count > 5 ? "m'" . v:count : "") . "j"]], { expr = true })
map.nnoremap("k", [[(v:count > 5 ? "m'" . v:count : "") . "k"]], { expr = true })

-- Add more undo break-points
map.inoremap(",", ",<c-g>u")
map.inoremap(".", ".<c-g>u")
map.inoremap(";", ";<c-g>u")

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
