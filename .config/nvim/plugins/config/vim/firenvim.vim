augroup FireNVIM
  autocmd!

  au BufEnter github.com_*.txt set filetype=markdown
  au BufEnter *graphql*.txt set filetype=graphql
augroup END

" let fc = g:firenvim_config['localSettings']
" let fc['https?://twitter.com/'] = { 'takeover': 'never', 'priority': 1 }
