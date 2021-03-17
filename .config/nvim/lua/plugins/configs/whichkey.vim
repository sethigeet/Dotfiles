" Leader Key Maps

let @s = 'veS"'

" Timeout
let g:which_key_timeout = 100

let g:which_key_display_names = {'<CR>': '↵', '<TAB>': '⇆'}

" Map Leader to which_key
nnoremap <silent> <Space> :silent <C-u> :silent WhichKey '<Space>'<CR>
vnoremap <silent> <Space> :silent <C-u> :silent WhichKeyVisual '<Space>'<CR>

" Create map to add keys to
let g:which_key_map =  {}
" Define a separator
let g:which_key_sep = '→'
" set timeoutlen=100

" Not a fan of floating windows for this
let g:which_key_use_floating_win = 0
let g:which_key_max_size = 0

" let g:which_key_position = 'botright'
" let g:which_key_position = 'topleft'
" let g:which_key_vertical = 1

" Change the colors if you want

" Hide status line
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler


" Single mappings
let g:which_key_map['/'] = [ ':call Comment()'                                 , 'comment' ]
let g:which_key_map['?'] = [ ':NvimTreeFindFile'                               , 'comment' ]
let g:which_key_map['.'] = [ ':e $MYVIMRC'                                     , 'open init' ]
let g:which_key_map[';'] = [ ':Commands'                                       , 'commands' ]
let g:which_key_map['='] = [ '<C-W>='                                          , 'balance windows' ]
let g:which_key_map['e'] = [ ':NvimTreeToggle'                                 , 'explorer' ]
let g:which_key_map['f'] = [ ':Telescope find_files'                           , 'find files' ]
let g:which_key_map['h'] = [ '<C-W>s'                                          , 'split below']
let g:which_key_map['n'] = [ ':let @/ = ""'                                    , 'no highlight' ]
let g:which_key_map['p'] = [ ':Files'                                          , 'search files' ]
let g:which_key_map['T'] = [ ':TSHighlightCapturesUnderCursor'                 , 'treesitter highlight' ]
let g:which_key_map['u'] = [ ':UndotreeToggle'                                 , 'undo tree']
let g:which_key_map['v'] = [ '<C-W>v'                                          , 'split right']
let g:which_key_map['W'] = [ ':call WindowSwap#EasyWindowSwap()'               , 'move window' ]

" Group mappings

" a is for actions
let g:which_key_map.a = {
      \ 'name' : '+actions' ,
      \ 'c' : [':ColorizerToggle'                        , 'colorizer'],
      \ 'h' : [':let @/ = ""'                            , 'remove search highlight'],
      \ 'l' : [':Bracey'                                 , 'start live server'],
      \ 'L' : [':BraceyStop'                             , 'stop live server'],
      \ 'm' : [':Glow'                                   , 'markdown preview'],
      \ 'n' : [':set nonumber!'                          , 'line-numbers'],
      \ 's' : [':s/\%V\(.*\)\%V/"\1"/'                   , 'surround'],
      \ 'r' : [':set norelativenumber!'                  , 'relative line nums'],
      \ 't' : [':FloatermToggle'                         , 'terminal'],
      \ 'v' : [':Codi'                                   , 'virtual repl on'],
      \ 'V' : [':Codi!'                                  , 'virtual repl off'],
      \ }

" b is for buffer
let g:which_key_map.b = {
      \ 'name' : '+buffer' ,
      \ '>' : [':BufferMoveNext'                         , 'move next'],
      \ '<' : [':BufferMovePrevious'                     , 'move prev'],
      \ '1' : [':BufferGoto 1'                           , 'buffer 1'],
      \ '2' : [':BufferGoto 2'                           , 'buffer 2'],
      \ '3' : [':BufferGoto 3'                           , 'buffer 3'],
      \ '4' : [':BufferGoto 4'                           , 'buffer 4'],
      \ '5' : [':BufferGoto 5'                           , 'buffer 5'],
      \ '6' : [':BufferGoto 6'                           , 'buffer 6'],
      \ '7' : [':BufferGoto 7'                           , 'buffer 7'],
      \ '8' : [':BufferGoto 8'                           , 'buffer 8'],
      \ '9' : [':BufferGoto 9'                           , 'buffer 9'],
      \ '0' : [':BufferGoto 0'                           , 'buffer 0'],
      \ 'b' : [':BufferPick'                             , 'pick buffer'],
      \ 'd' : [':Bdelete'                                , 'delete-buffer'],
      \ 'D' : [':BufferOrderByDirectory'                 , 'order by directory'],
      \ 'f' : ['bfirst'                                  , 'first-buffer'],
      \ 'l' : ['blast'                                   , 'last buffer'],
      \ 'L' : [':BufferOrderByLanguage'                  , 'order by language'],
      \ 'n' : ['bnext'                                   , 'next-buffer'],
      \ 'p' : ['bprevious'                               , 'previous-buffer'],
      \ }

" F is for fold
let g:which_key_map.F = {
    \ 'name': '+fold',
    \ 'O' : [':set foldlevel=20', 'open all'],
    \ 'C' : [':set foldlevel=0', 'close all'],
    \ 'c' : [':foldclose', 'close'],
    \ 'o' : [':foldopen', 'open'],
    \ '1' : [':set foldlevel=1', 'level1'],
    \ '2' : [':set foldlevel=2', 'level2'],
    \ '3' : [':set foldlevel=3', 'level3'],
    \ '4' : [':set foldlevel=4', 'level4'],
    \ '5' : [':set foldlevel=5', 'level5'],
    \ '6' : [':set foldlevel=6', 'level6']
    \ }

" g is for git
let g:which_key_map.g = {
      \ 'name' : '+git' ,
      \ 'a' : [':Git add .'                                , 'add all'],
      \ 'b' : [':Git blame'                                , 'blame'],
      \ 'B' : [':GBrowse'                                  , 'browse'],
      \ 'c' : [':Git commit'                               , 'commit'],
      \ 'd' : [':Git diff'                                 , 'diff'],
      \ 'D' : [':Gdiffsplit'                               , 'diff split'],
      \ 'g' : [':GGrep'                                    , 'git grep'],
      \ 'G' : [':Gstatus'                                  , 'status'],
      \ 'H' : [':PreviewHunk'                              , 'preview hunk'],
      \ 'j' : [':NextHunk'                                 , 'next hunk'],
      \ 'k' : [':PrevHunk'                                 , 'prev hunk'],
      \ 'l' : [':Git log'                                  , 'log'],
      \ 'm' : ['<Plug>(git-messenger)'                     , 'message'],
      \ 'p' : [':Git push'                                 , 'push'],
      \ 'P' : [':Git pull'                                 , 'pull'],
      \ 'r' : [':GRemove'                                  , 'remove'],
      \ 'R' : [':ResetHunk'                                , 'reset hunk'],
      \ 's' : [':StageHunk'                                , 'stage hunk'],
      \ 't' : [':GitGutterSignsToggle'                     , 'toggle signs'],
      \ 'u' : [':UndoStageHunk'                            , 'undo stage hunk'],
      \ 'v' : [':GV'                                       , 'view commits'],
      \ 'V' : [':GV!'                                      , 'view buffer commits'],
      \ }
      " \ 'A' : [':Git add %'                                , 'add current'],
      " \ 'S' : [':!git status'                              , 'status'],

" l is for language server protocol(lsp)
let g:which_key_map.l = {
      \ 'name' : '+lsp' ,
      \ 'a' : [':Lspsaga code_action'                     , 'quickfix'],
      \ 'A' : [':Lspsaga range_code_action'               , 'selected action'],
      \ 'd' : [':Telescope lsp_document_diagnostics'      , 'document diagnostics'],
      \ 'D' : [':Telescope lsp_workspace_diagnostics'     , 'workspace diagnostics'],
      \ 'f' : [':LspFormatting'                           , 'format'],
      \ 'H' : [':Lspsaga signature_help'                  , 'signature_help'],
      \ 'I' : [':LspInfo'                                 , 'lsp_info'],
      \ 'l' : [':Lspsaga lsp_finder'                      , 'lsp_finder'],
      \ 'L' : [':Lspsaga show_line_diagnostics'           , 'line_diagnostics'],
      \ 'o' : [':Vista!!'                                 , 'outline'],
      \ 'p' : [':Lspsaga preview_definition'              , 'preview definition'],
      \ 'q' : [':Telescope quickfix'                      , 'quickfix'],
      \ 'r' : [':Lspsaga rename'                          , 'rename'],
      \ 'T' : [':LspTypeDefinition'                       , 'type defintion'],
      \ 'x' : [':cclose'                                  , 'close quickfix'],
      \ 's' : [':Telescope lsp_document_symbols'          , 'document symbols'],
      \ 'S' : [':Telescope lsp_workspace_symbols'         , 'workspace symbols'],
      \ }
      " \ 'D' : [':LspDeclaration'                        , 'workspace_diagnostics'],
      " \ 'r' : [':Telescope lsp_references'              , 'references'],
      " \ 'p' : [':Lspsaga diagnostic_jump_prev'          , 'prev diagnostic'],
      " \ 'n' : [':Lspsaga diagnostic_jump_next'          , 'next_diagnostic'],
      " \ 'q' : [':Lspsaga code_action'                   , 'quickfix'],
      " \ 'i' : [':LspImplementation'                     , 'lsp_info'],
      " \ 'h' : [':Lspsaga hover_doc'                     , 'hover_doc'],
      " \ 'K' : [':LspHover'                              , 'hover'],

" s is for search
let g:which_key_map.s = {
      \ 'name' : '+search',
      \ '.' : [':Telescope filetypes'                   , 'filetypes'],
      \ ';' : [':Telescope commands'                    , 'commands'],
      \ 'a' : [':Telescope lsp_code_actions'            , 'code_actions'],
      \ 'A' : [':Telescope builtin'                     , 'all'],
      \ 'b' : [':Telescope buffers'                     , 'buffers'],
      \ 'B' : [':Telescope git_branches'                , 'git branches'],
      \ 'd' : [':Telescope lsp_document_diagnostics'    , 'document diagnostics'],
      \ 'D' : [':Telescope lsp_workspace_diagnostics'   , 'workspace diagnostics'],
      \ 'c' : [':Telescope git_commits'                 , 'git commits'],
      \ 'f' : [':Telescope find_files'                  , 'files'],
      \ 'F' : [':Telescope git_files'                   , 'git files'],
      \ 'g' : [':Telescope tags'                        , 'tags'],
      \ 'G' : [':Telescope current_buffer_tags'         , 'buffer_tags'],
      \ 'h' : [':Telescope command_history'             , 'history'],
      \ 'H' : [':Telescope help_tags'                   , 'help_tags'],
      \ 'i' : [':Telescope media_files'                 , 'media files'],
      \ 'k' : [':Telescope keymaps'                     , 'keymaps'],
      \ 'l' : [':Telescope loclist'                     , 'loclist'],
      \ 'm' : [':Telescope marks'                       , 'marks'],
      \ 'M' : [':Telescope man_pages'                   , 'man pages'],
      \ 'o' : [':Telescope vim_options'                 , 'vim options'],
      \ 'O' : [':Telescope oldfiles'                    , 'oldfiles'],
      \ 'p' : [':Telescope fd'                          , 'fd'],
      \ 'P' : [':Telescope spell_suggest'               , 'spell suggest'],
      \ 's' : [':Telescope git_status'                  , 'git status'],
      \ 'S' : [':Telescope grep_string'                 , 'grep string'],
      \ 't' : [':Telescope live_grep'                   , 'text'],
      \ 'y' : [':Telescope symbols'                     , 'symbols'],
      \ 'Y' : [':Telescope lsp_workspace_symbols'       , 'lsp workspace symbols'],
      \ 'r' : [':Telescope registers'                   , 'registers'],
      \ 'R' : [':Telescope reloader'                    , 'reloader'],
      \ 'w' : [':Telescope file_browser'                , 'file browser'],
      \ 'u' : [':Telescope colorscheme'                 , 'colorschemes'],
      \ 'z' : [':Telescope current_buffer_fuzzy_find'   , 'buf fuz find'],
      \ }

let g:which_key_map.S = {
      \ 'name' : '+Session',
      \ 'c' : [':SClose'                                  , 'Close Session'],
      \ 'd' : [':SDelete'                                 , 'Delete Session'],
      \ 'l' : [':SLoad'                                   , 'Load Session'],
      \ 's' : [':Startify'                                , 'Start Page'],
      \ 'S' : [':SSave'                                   , 'Save Session'],
      \ }

" t is for terminal
let g:which_key_map.t = {
      \ 'name' : '+terminal' ,
      \ ';' : [':FloatermNew --wintype=normal --height=6' , 'terminal'],
      \ 'b' : [':FloatermNew bpytop'                      , 'bpytop'],
      \ 'g' : [':FloatermNew lazygit'                     , 'git'],
      \ 'd' : [':FloatermNew lazydocker'                  , 'docker'],
      \ 'n' : [':FloatermNew node'                        , 'node'],
      \ 'p' : [':FloatermNew python'                      , 'python'],
      \ 'm' : [':FloatermNew lazynpm'                     , 'npm'],
      \ 't' : [':FloatermToggle'                          , 'toggle'],
      \ 'v' : [':FloatermNew vifm'                        , 'vifm'],
      \ }

" Register which key map
call which_key#register('<Space>', "g:which_key_map")
