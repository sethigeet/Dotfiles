"    ____      _ __        _
"   /  _/___  (_) /__   __(_)___ ___
"   / // __ \/ / __/ | / / / __ `__ \
" _/ // / / / / /__| |/ / / / / / / /
"/___/_/ /_/_/\__(_)___/_/_/ /_/ /_/

" General Settings
if !exists('g:vscode')
  source ~/.config/nvim/plug-config/polyglot.vim
endif

source ~/.config/nvim/plugins/plugins.vim
source ~/.config/nvim/general/settings.vim
source ~/.config/nvim/general/functions.vim
source ~/.config/nvim/keys/mappings.vim

if exists('g:vscode')
  " VS Code extension
  source ~/.config/nvim/vscode/settings.vim
  source ~/.config/nvim/plugins/config/vim/easymotion.vim
  source ~/.config/nvim/plugins/config/vim/highlightyank.vim
else

  if exists('g:started_by_firenvim')
    source ~/.config/nvim/plugins/config/vim/firenvim.vim
  else

    " Themes
    source ~/.config/nvim/themes/syntax.vim
    source ~/.config/nvim/themes/ayu.vim

    " Plugin Configuration
    source ~/.config/nvim/plugins/config/vim/vim-commentary.vim
    source ~/.config/nvim/plugins/config/vim/codi.vim
    source ~/.config/nvim/plugins/config/vim/vim-wiki.vim
    source ~/.config/nvim/plugins/config/vim/easymotion.vim
    source ~/.config/nvim/plugins/config/vim/vim-rooter.vim
    source ~/.config/nvim/plugins/config/vim/start-screen.vim
    source ~/.config/nvim/plugins/config/vim/gitgutter.vim
    source ~/.config/nvim/plugins/config/vim/git-messenger.vim
    source ~/.config/nvim/plugins/config/vim/floaterm.vim
    source ~/.config/nvim/plugins/config/vim/barbar.vim
    source ~/.config/nvim/plugins/config/vim/tagalong.vim
    source ~/.config/nvim/plugins/config/vim/bracey.vim
    source ~/.config/nvim/plugins/config/vim/window-swap.vim
    source ~/.config/nvim/plugins/config/vim/markdown-preview.vim
    source ~/.config/nvim/plugins/config/vim/illuminate.vim
    source ~/.config/nvim/plugins/config/vim/quickscope.vim
    luafile ~/.config/nvim/plugins/config/lua/plug-colorizer.lua
    luafile ~/.config/nvim/plugins/config/lua/telescope.lua
    luafile ~/.config/nvim/plugins/config/lua/galaxyline.lua
    luafile ~/.config/nvim/plugins/config/lua/treesitter.lua
    luafile ~/.config/nvim/plugins/config/lua/nvimtree.lua

  endif

  source ~/.config/nvim/plugins/config/vim/rainbow.vim
  source ~/.config/nvim/plugins/config/vim/indentLine.vim
  source ~/.config/nvim/plugins/config/vim/closetags.vim
  source ~/.config/nvim/keys/which-key.vim

  " LSP (refer to: https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md)
  luafile ~/.config/nvim/plugins/config/lsp/lsp-kind.lua
  luafile ~/.config/nvim/plugins/config/lua/compe-config.lua
  luafile ~/.config/nvim/plugins/config/lua/lspsaga-config.lua
  source ~/.config/nvim/plugins/config/lsp/wrapper/lsp-wrapper.vim
  source ~/.config/nvim/plugins/config/lsp/config/lsp-config.vim
  luafile ~/.config/nvim/plugins/config/lsp/config/lsp-config.lua
  luafile ~/.config/nvim/plugins/config/lsp/language-servers/general.lua
  luafile ~/.config/nvim/plugins/config/lsp/language-servers/lua.lua
  luafile ~/.config/nvim/plugins/config/lsp/language-servers/python.lua
  luafile ~/.config/nvim/plugins/config/lsp/language-servers/bash.lua
  luafile ~/.config/nvim/plugins/config/lsp/language-servers/css.lua
  luafile ~/.config/nvim/plugins/config/lsp/language-servers/docker.lua
  luafile ~/.config/nvim/plugins/config/lsp/language-servers/graphql.lua
  luafile ~/.config/nvim/plugins/config/lsp/language-servers/html.lua
  luafile ~/.config/nvim/plugins/config/lsp/language-servers/javascript.lua
  luafile ~/.config/nvim/plugins/config/lsp/language-servers/json.lua
  luafile ~/.config/nvim/plugins/config/lsp/language-servers/vim.lua
  luafile ~/.config/nvim/plugins/config/lsp/language-servers/yaml.lua
endif


" Add paths to node and python here
if !empty(glob("~/.config/nvim/paths.vim"))
  source ~/.config/nvim/paths.vim
endif
