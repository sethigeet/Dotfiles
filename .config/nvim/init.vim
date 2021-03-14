"    ____      _ __        _
"   /  _/___  (_) /__   __(_)___ ___
"   / // __ \/ / __/ | / / / __ `__ \
" _/ // / / / / /__| |/ / / / / / / /
"/___/_/ /_/_/\__(_)___/_/_/ /_/ /_/

" General Settings
if !exists('g:vscode')
  source ~/.config/nvim/plug-config/polyglot.vim
endif

source ~/.config/nvim/vim-plug/plugins.vim
source ~/.config/nvim/general/settings.vim
source ~/.config/nvim/general/functions.vim
source ~/.config/nvim/keys/mappings.vim

if exists('g:vscode')
  " VS Code extension
  source ~/.config/nvim/vscode/settings.vim
  source ~/.config/nvim/plug-config/easymotion.vim
  source ~/.config/nvim/plug-config/highlightyank.vim
else

  if exists('g:started_by_firenvim')
    source ~/.config/nvim/plug-config/firenvim.vim
  else

    " Themes
    source ~/.config/nvim/themes/syntax.vim
    source ~/.config/nvim/themes/ayu.vim

    " Plugin Configuration
    source ~/.config/nvim/plug-config/vim-commentary.vim
    source ~/.config/nvim/plug-config/codi.vim
    source ~/.config/nvim/plug-config/vim-wiki.vim
    luafile ~/.config/nvim/lua/nvcodeline.lua
    luafile ~/.config/nvim/lua/treesitter.lua
    source ~/.config/nvim/plug-config/easymotion.vim
    source ~/.config/nvim/plug-config/vim-rooter.vim
    source ~/.config/nvim/plug-config/start-screen.vim
    source ~/.config/nvim/plug-config/gitgutter.vim
    source ~/.config/nvim/plug-config/git-messenger.vim
    source ~/.config/nvim/plug-config/floaterm.vim
    source ~/.config/nvim/plug-config/barbar.vim
    source ~/.config/nvim/plug-config/tagalong.vim
    source ~/.config/nvim/plug-config/bracey.vim
    source ~/.config/nvim/plug-config/window-swap.vim
    source ~/.config/nvim/plug-config/markdown-preview.vim
    source ~/.config/nvim/plug-config/illuminate.vim
    luafile ~/.config/nvim/lua/plug-colorizer.lua

  endif

  source ~/.config/nvim/plug-config/rainbow.vim
  source ~/.config/nvim/plug-config/indentLine.vim
  source ~/.config/nvim/plug-config/coc/coc.vim
  source ~/.config/nvim/plug-config/coc/coc-extensions.vim
  source ~/.config/nvim/plug-config/closetags.vim
  source ~/.config/nvim/keys/which-key.vim
endif

source ~/.config/nvim/plug-config/quickscope.vim

" Add paths to node and python here
if !empty(glob("~/.config/nvim/paths.vim"))
  source ~/.config/nvim/paths.vim
endif
