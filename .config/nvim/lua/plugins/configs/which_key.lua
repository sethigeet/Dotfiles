local wk = require("which-key")

wk.setup({
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    presets = {
      operators = false, -- adds help for operators like d, y, ...
      motions = false, -- adds help for motions
      text_objects = false, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = false, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = " ", -- symbol prepended to a group
  },
  window = {
    border = "none", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 0, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 1, 1, 1, 1 }, -- extra window padding [top, right, bottom, left]
  },
  layout = {
    height = { min = 5, max = 15 }, -- min and max height of the columns
    width = { min = 4, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
  },
  ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", ":", ":", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = "auto", -- automatically setup triggers
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k", "<Space>" },
    c = { "j", "k" },
  },
})

local function getOpts(mode, prefix)
  local actual_prefix
  if prefix then
    actual_prefix = prefix
  else
    actual_prefix = "<leader>"
  end

  return {
    mode = mode, -- vim mode
    -- prefix: use "<leader>f" for example for mapping everything related to finding files
    -- the prefix is prepended to every mapping part of `mappings`
    prefix = actual_prefix,
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
  }
end

-- Set leader
vim.api.nvim_set_keymap("n", "<Space>", "<NOP>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<Space>", "<NOP>", { noremap = true, silent = true })
vim.g.mapleader = " "

-- Hide the status line for the which-key window
require("general.functions").DefineAugroups({
  which_key = {
    { "FileType", "which_key", "set laststatus=0 noshowmode noruler" },
    { "BufLeave", "<buffer>", "set laststatus=2 noshowmode ruler" },
  },
})

local mappings = {
  ["/"] = { ":call v:lua.Comment()<CR>", "comment" },
  ["?"] = { ":NvimTreeFindFile<CR>", "show file in tree" },
  ["="] = { "<C-W>=", "balance windows" },
  [";"] = { ":Dashboard<CR>", "show start screen" },
  e = { ":NvimTreeToggle<CR>", "explorer" },
  f = { ":Telescope find_files<CR>", "find files" },
  h = { "<C-W>s", "split below" },
  M = { ":MarkdownPreviewToggle<CR>", "markdown preview" },
  n = { ':let @/ = ""<CR>', "no highlight" },
  u = { ":UndotreeToggle<CR>", "undo tree" },
  v = { "<C-W>v", "split right" },
  w = { ":w<CR>", "save file" },

  -- a is for Action
  a = {
    name = "Actions",
    c = { ":ColorizerToggle<CR>", "colorizer" },
    h = { ":nohl<CR>", "remove search highlight" },
    i = { ":IndentBlanklineToggle<CR>", "toggle indent lines" },
    m = { ":Glow<CR>", "markdown preview" },
    n = { ":set nonumber!<CR>", "line-numbers" },
    s = { "<Plug>SortMotionVisual", "sort selected text" },
    r = { ":set norelativenumber!<CR>", "relative line nums" },
    t = { ":FloatermToggle<CR>", "terminal" },
    v = { ":Codi<CR>", "virtual repl on" },
    V = { ":Codi!<CR>", "virtual repl off" },
  },

  -- b is for Buffer
  b = {
    name = "Buffer",
    d = { ":Bdelete<CR>", "delete buffer" },
    f = { ":Telescope buffers<CR>", "search buffers" },
    j = { ":BufferLineCyclePrev<CR>", "previous buffer" },
    k = { ":BufferLineCycleNext<CR>", "next buffer" },
    h = { ":BufferLineCloseRight<CR>", "close right buffer" },
    l = { ":BufferLineCloseLeft<CR>", "close left buffer" },
    H = { ":BufferLineMovePrev<CR>", "move to previous" },
    L = { ":BufferLineMoveNext<CR>", "move to next" },
    p = { ":BufferLinePick<CR>", "pick buffer" },
    s = {
      name = "Sort",
      d = { ":BufferLineSortByDirectory", "by directory" },
      e = { ":BufferLineSortByExtension", "by extension" },
      r = { ":BufferLineSortByRelativeDirector", "by relative directory" },
    },
  },

  -- d is for Database
  d = {
    name = "Database",
    t = { ":DBUIToggle<CR>", "toggle ui" },
    f = { ":DBUIFindBuffer<CR>", "find buffer" },
    r = { ":DBUIRenameBuffer<CR>", "rename buffer" },
    i = { ":DBUILastQueryInfo<CR>", "last query info" },
  },

  -- F is for Fold
  F = {
    name = "Fold",
    O = { ":set foldlevel=20<CR>", "open all" },
    C = { ":set foldlevel=0<CR>", "close all" },
    c = { ":foldclose<CR>", "close" },
    o = { ":foldopen<CR>", "open" },
    ["1"] = { ":set foldlevel=1<CR>", "level 1" },
    ["2"] = { ":set foldlevel=2<CR>", "level 2" },
    ["3"] = { ":set foldlevel=3<CR>", "level 3" },
    ["4"] = { ":set foldlevel=4<CR>", "level 4" },
    ["5"] = { ":set foldlevel=5<CR>", "level 5" },
    ["6"] = { ":set foldlevel=6<CR>", "level 6" },
  },

  -- g is for Git
  g = {
    name = "Git",
    a = { ":Git add .<CR>", "add all" },
    -- b = { ":Git blame<CR>", "blame" },
    b = { ":Telescope git_branches<CR>", "Checkout branch" },
    B = { ":GBrowse<CR>", "browse" },
    c = {
      name = "Commits",
      c = { ":Git commit<CR>", "commit" },
      o = { ":Telescope git_commits<CR>", "Checkout commit" },
      u = { ":Telescope git_bcommits<CR>", "Checkout commit(for current file)" },
    },
    d = { ":Git diff<CR>", "diff" },
    D = { ":Gdiffsplit<CR>", "diff split" },
    g = { ":GGrep<CR>", "git grep" },
    G = { ":Gstatus<CR>", "status" },
    H = { ":lua require('gitsigns').preview_hunk()<CR>", "preview hunk" },
    j = { ":lua require('gitsigns').next_hunk()<CR>", "next hunk" },
    k = { ":lua require('gitsigns').prev_hunk()<CR>", "prev hunk" },
    l = { ":Git log<CR>", "log" },
    m = { "<Plug>(git-messenger)<CR>", "message" },
    p = { ":Git push<CR>", "push" },
    P = { ":Git pull<CR>", "pull" },
    r = { ":GRemove<CR>", "remove" },
    R = { ":lua require('gitsigns').reset_hunk()<CR>", "reset hunk" },
    s = { ":lua require('gitsigns').stage_hunk()<CR>", "stage hunk" },
    t = { ":GitGutterSignsToggle<CR>", "toggle signs" },
    u = { ":lua require('gitsigns').undo_stage_hunk()<CR>", "undo stage hunk" },
    S = { ":Telescope git_status<CR>", "Open changed file" },
    A = { ":Git add %<CR>", "add current" },
    -- S = { ":!git status<CR>", "status" }
  },

  -- l is for LSP
  l = {
    name = "LSP",
    a = { ":Lspsaga code_action<CR>", "code actions" },
    A = { ":Lspsaga range_code_action<CR>", "selected action" },
    d = { ":Telescope lsp_document_diagnostics<CR>", "document diagnostics" },
    D = { ":Telescope lsp_workspace_diagnostics<CR>", "workspace diagnostics" },
    f = { ":lua vim.lsp.buf.formatting()<CR>", "format" },
    H = { ":Lspsaga signature_help<CR>", "signature_help" },
    I = { ":LspInfo<CR>", "lsp info" },
    j = { ":Lspsaga diagnostic_jump_prev<CR>", "prev Diagnostic" },
    k = { ":Lspsaga diagnostic_jump_next<CR>", "next Diagnostic" },
    l = { ":Lspsaga lsp_finder<CR>", "lsp finder" },
    L = { ":Lspsaga show_line_diagnostics<CR>", "line diagnostics" },
    o = { ":SymbolsOutline<CR>", "outline" },
    p = { ":Lspsaga preview_definition<CR>", "preview definition" },
    P = { ":call v:lua.PeekDefinition()<CR>", "peek definition" },
    q = { ":Telescope quickfix<CR>", "quickfix" },
    r = { ":Lspsaga rename<CR>", "rename" },
    T = { ":lua vim.lsp.buf.type_definition()<CR>", "type defintion" },
    v = { ":LspVirtualTextToggle<CR>", "toggle virtual text" },
    s = { ":Telescope lsp_document_symbols<CR>", "document symbols" },
    S = { ":Telescope lsp_workspace_symbols<CR>", "workspace symbols" },

    -- r = {":Telescope lsp_references<CR>", "references" },
    -- i = {":LspImplementation<CR>", "implementation" },
    -- h = {":Lspsaga hover_doc<CR>", "hover doc" },
  },

  -- m is for Mark
  m = {
    name = "Mark",
    a = { ":BookmarkShowAll<CR>", "show all" },
    c = { ":BookmarkClear<CR>", "clear" },
    d = { ":BookmarkClearAll<CR>", "clear all" },
    j = { ":BookmarkNext<CR>", "next mark" },
    k = { ":BookmarkPrev<CR>", "prev mark" },
    l = { ":BookmarkLoad<CR>", "load" },
    s = { ":BookmarkSave<CR>", "save" },
    t = { ":BookmarkToggle<CR>", "toggle" },
  },

  p = {
    name = "Packer",
    c = { ":PackerCompile<CR>", "Compile" },
    i = { ":PackerInstall<CR>", "Install" },
    r = { ":luafile $MYVIMRC<CR>", "Reload" },
    s = { ":PackerSync<CR>", "Sync" },
    u = { ":PackerUpdate<CR>", "Update" },
  },

  -- q is for Quickfix
  q = {
    name = "Quickfix",
    w = { ":Trouble lsp_workspace_diagnostics<CR>", "lsp workspace diagnostics" },
    d = { ":Trouble lsp_document_diagnostics<CR>", "lsp document diagnostics" },
    r = { ":Trouble lsp_references<CR>", "lsp references" },
    t = { ":Trouble todo<CR>", "todos" },
    q = { ":call v:lua.ToggleQFList(1)<CR>", "quickfix list" },
    l = { ":call v:lua.ToggleQFList(0)<CR>", "location list" },
  },

  -- r is for Run
  r = {
    name = "Run",
    r = { "<Plug>SnipRun<CR>", "Run the selected piece of code" },
    s = { "<Plug>SnipReset<CR>", "Stop the running code" },
    c = { "<Plug>SnipClose<CR>", "Clear the previous output" },
    m = { "<Plug>SnipReplMemoryClean<CR>", "Clean the repl memory" },
  },

  -- R is for REST Client
  R = {
    name = "REST Client",
    r = { "<Plug>RestNvim<CR>", "run" },
    p = { "<Plug>RestNvimPreview<CR>", "preview" },
  },

  -- s is for Search
  s = {
    name = "Search",
    ["."] = { ":Telescope filetypes<CR>", "filetypes" },
    [";"] = { ":Telescope commands<CR>", "commands" },
    a = { ":Telescope lsp_code_actions<CR>", "code actions" },
    A = { ":Telescope builtin<CR>", "all" },
    b = { ":Telescope buffers<CR>", "buffers" },
    B = { ":Telescope git_branches<CR>", "git branches" },
    d = { ":Telescope lsp_document_diagnostics<CR>", "document diagnostics" },
    D = { ":Telescope lsp_workspace_diagnostics<CR>", "workspace diagnostics" },
    c = { ":Telescope git_commits<CR>", "git commits" },
    f = { ":Telescope find_files<CR>", "files" },
    F = { ":Telescope git_files<CR>", "git files" },
    -- g = { ":Telescope tags<CR>", "tags" },
    g = { ":Telescope live_grep<CR>", "text" },
    G = { ":Telescope current_buffer_tags<CR>", "buffer_tags" },
    h = { ":Telescope command_history<CR>", "history" },
    H = { ":Telescope help_tags<CR>", "help_tags" },
    i = { ":Telescope media_files<CR>", "media files" },
    k = { ":Telescope keymaps<CR>", "keymaps" },
    l = { ":Telescope loclist<CR>", "loclist" },
    m = { ":Telescope marks<CR>", "marks" },
    M = { ":Telescope man_pages<CR>", "man pages" },
    o = { ":Telescope vim_options<CR>", "vim options" },
    O = { ":Telescope oldfiles<CR>", "oldfiles" },
    p = { ":Telescope project<CR>", "projects" },
    P = { ":Telescope spell_suggest<CR>", "spell suggest" },
    s = { ":Telescope git_status<CR>", "git status" },
    S = { ":Telescope grep_string<CR>", "grep string" },
    t = { ":TodoTelescope<CR>", "todos" },
    y = { ":Telescope symbols<CR>", "symbols" },
    Y = { ":Telescope lsp_workspace_symbols<CR>", "lsp workspace symbols" },
    r = { ":Telescope registers<CR>", "registers" },
    R = { ":Telescope reloader<CR>", "reloader" },
    w = { ":Telescope file_browser<CR>", "file browser" },
    u = { ":Telescope colorscheme<CR>", "colorschemes" },
    z = { ":Telescope current_buffer_fuzzy_find<CR>", "buf fuz find" },
  },

  -- S is for Search and replace
  S = {
    name = "Search and Replace",
    o = { ":lua require('spectre').open()<CR>", "open search" },
    v = { ":lua require('spectre').open_visual()<CR>", "open visual" },
    f = { ":lua require('spectre').open_file_search()<CR>", "open file search" },
    a = {
      name = "Actions",
      q = "Send to quickfix list",
      c = "Input replace vim command",
      r = "Replace all",
      o = "Show options",
      v = "Change view mode",
    },
  },

  -- t is for Treesitter
  -- NOTE: These keybindings are actually defined in the `treesitter` config and only given proper names here
  t = {
    name = "Treesitter",
    r = "rename",
    d = "goto definition",
    l = "list definitions",
    t = "list definitions toc",
    ["*"] = "goto next usage",
    ["#"] = "goto previous usage",
    s = {
      name = "Swap",
      f = "next function",
      c = "next class",
      l = "next loop",
      i = "next conditional",
      p = "next parameter",
      b = "next block",

      F = "previous function",
      C = "previous class",
      L = "previous loop",
      I = "previous conditional",
      P = "previous parameter",
      B = "previous block",
    },
  },

  -- T is for Terminal
  T = {
    name = "Terminal",
    d = { ":call v:lua.__fterm_toggle('dropdown')<CR>", "dropdown" },
    g = { ":call v:lua.__fterm_toggle('lazygit')<CR>", "git" },
    n = { ":call v:lua.__fterm_toggle('node')<CR>", "node" },
    p = { ":call v:lua.__fterm_toggle('python')<CR>", "python" },
    t = { ":call v:lua.__fterm_toggle()<CR>", "toggle" },
  },

  -- z is for Zen Mode
  z = { ":ZenMode<CR>", "toggle zen mode" },
}

wk.register(mappings, getOpts("n"))
wk.register(mappings, getOpts("v"))

-- Treesitter move plugin keybindings
local function getBracketMappings(next, start)
  local dir = next and "next" or "previous"
  local towards = start and "start" or "end"

  local bracketMappings = {
    f = "goto " .. dir .. " function " .. towards,
    c = "goto " .. dir .. " class " .. towards,
    l = "goto " .. dir .. " loop " .. towards,
    i = "goto " .. dir .. " conditional " .. towards,
    p = "goto " .. dir .. " parameter " .. towards,
    b = "goto " .. dir .. " block " .. towards,
  }

  local actualBracketMappings = {}
  for key, obj in pairs(bracketMappings) do
    local actual_key = start and key or string.upper(key)
    actualBracketMappings[string.format("%s", actual_key)] = obj
  end

  return actualBracketMappings
end

wk.register(getBracketMappings(true, true), getOpts("n", "]"))
wk.register(getBracketMappings(true, false), getOpts("n", "]"))
wk.register(getBracketMappings(false, true), getOpts("n", "["))
wk.register(getBracketMappings(false, false), getOpts("n", "["))
