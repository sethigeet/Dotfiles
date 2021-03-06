" Basic Key Mappings

imap <C-h> <C-w>h
imap <C-j> <C-w>j
imap <C-k> <C-w>k
imap <C-l> <C-w>l

" Global Leader key
let mapleader=" "
" let localLeader=" "
nnoremap <Space> <Nop>

" Better indenting
vnoremap < <gv
vnoremap > >gv

" Fixed the 'Y' behavior
nmap Y y$

if exists('g:vscode')

  " Simulate same TAB behavior in VSCode
  nmap <Tab> :Tabnext<CR>
  nmap <S-Tab> :Tabprev<CR>

else

  " Better nav for omnicomplete
  inoremap <expr> <c-j> ("\<C-n>")
  inoremap <expr> <c-k> ("\<C-p>")

  " I hate escape more than anything else
  inoremap jk <Esc>
  inoremap kj <Esc>

  " Easy CAPS
  inoremap <c-u> <ESC>viwUi
  nnoremap <c-u> viwU<Esc>

  " TAB in general mode will move to text buffer
  nnoremap <silent> <TAB> :bnext<CR>
  " SHIFT-TAB will go back
  nnoremap <silent> <S-TAB> :bprevious<CR>

  " Move selected line / block of text in visual mode
  " shift + k to move up
  " shift + j to move down
  xnoremap K :move '<-2<CR>gv-gv
  xnoremap J :move '>+1<CR>gv-gv

  " Alternate way to save
  nnoremap <silent> <C-s> :w<CR>
  " Alternate way to quit
  nnoremap <silent> <C-Q> :wq!<CR>
  " Use control-c instead of escape
  nnoremap <silent> <C-c> <Esc>
  " <TAB>: completion.
  inoremap <silent> <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

  " Better window navigation
  nnoremap <M-h> <C-w>h
  nnoremap <M-j> <C-w>j
  nnoremap <M-k> <C-w>k
  nnoremap <M-l> <C-w>l

  " Terminal window navigation
  tnoremap <M-h> <C-\><C-N><C-w>h
  tnoremap <M-j> <C-\><C-N><C-w>j
  tnoremap <M-k> <C-\><C-N><C-w>k
  tnoremap <M-l> <C-\><C-N><C-w>l
  inoremap <M-h> <C-\><C-N><C-w>h
  inoremap <M-j> <C-\><C-N><C-w>j
  inoremap <M-k> <C-\><C-N><C-w>k
  inoremap <M-l> <C-\><C-N><C-w>l
  tnoremap <Esc> <C-\><C-n>

  " Use alt + left,down,up,right to resize windows
  nnoremap <silent> <M-Up>       :resize -2<CR>
  nnoremap <silent> <M-Down>     :resize +2<CR>
  nnoremap <silent> <M-Left>     :vertical resize -2<CR>
  nnoremap <silent> <M-Right>    :vertical resize +2<CR>

  " Use ctrl + left,down,up,right to resize windows
  " nnoremap <silent> <C-Up>    :resize -2<CR>
  " nnoremap <silent> <C-Down>  :resize +2<CR>
  " nnoremap <silent> <C-Left>  :vertical resize -2<CR>
  " nnoremap <silent> <C-Right> :vertical resize +2<CR>

  " let g:elite_mode=0                      " Disable arrows
  " Disable arrow movement, resize splits instead.
  " if get(g:, 'elite_mode')
  "     nnoremap <C-Up>    :resize -2<CR>
  "     nnoremap <C-Down>  :resize +2<CR>
  "     nnoremap <C-Left>  :vertical resize -2<CR>
  "     nnoremap <C-Right> :vertical resize +2<CR>
  " endif

endif

" Better nav for omnicomplete
inoremap <expr> <c-j> ("\<C-n>")
inoremap <expr> <c-k> ("\<C-p>")
