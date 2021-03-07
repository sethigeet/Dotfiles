" let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Custom prompt
let g:EasyMotion_prompt = ' '

" Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1

" Some other settings
let g:EasyMotion_verbose = 0
let g:EasyMotion_do_shade = 0

" Repeat last motion
map <leader><leader>. <Plug>(easymotion-repeat)

" Move to char
map <leader><leader>f <Plug>(easymotion-overwin-f)

" Move to line
map <leader><leader>j <Plug>(easymotion-overwin-line)
map <leader><leader>k <Plug>(easymotion-overwin-line)

" s{char}{char} to move to {char}{char}
nmap <silent> s <Plug>(easymotion-s2)
nmap <silent> S <Plug>(easymotion-overwin-f2)

" " Move to word
nmap <Leader><Leader>w <Plug>(easymotion-overwin-w)

