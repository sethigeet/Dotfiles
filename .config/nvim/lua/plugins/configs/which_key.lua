local wk = require("which-key")

local plugin = {}

function plugin.setup()
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

  plugin.keymaps()
  plugin.defineAugroups()
end

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

local mappings = {
  ["/"] = { "<Plug>kommentary_line_default", "comment" },
  ["?"] = { ":NvimTreeFindFile<CR>", "show file in tree" },
  ["="] = { "<C-W>=", "balance windows" },
  [";"] = { ":Dashboard<CR>", "show start screen" },
  e = { ":NvimTreeToggle<CR>", "explorer" },
  f = { ":Telescope fzf_writer files<CR>", "find files" },
  h = { "<C-W>s", "split below" },
  M = { ":MarkdownPreviewToggle<CR>", "markdown preview" },
  u = { ":UndotreeToggle<CR>", "undo tree" },
  v = { "<C-W>v", "split right" },
  w = { ":w<CR>", "save file" },
  z = { ":ZenMode<CR>", "toggle zen mode" },

  -- a is for Action
  a = {
    name = "Actions",
    c = { ":ColorizerToggle<CR>", "colorizer" },
    h = { ":nohl<CR>", "remove search highlight" },
    i = { ":IndentBlanklineToggle<CR>", "toggle indent lines" },
    n = { ":set nonumber!<CR>", "line-numbers" },
    r = { ":set norelativenumber!<CR>", "relative line nums" },
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

  -- NOTE: These keybindings are defined by the `kommentary` plugin itself
  c = {
    name = "Comment",
    i = {
      name = "Increase",
      c = "line",
    },
    d = {
      name = "Decrease",
      c = "line",
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
    A = { ":Git add %<CR>", "add current" },
    -- b = { ":Git blame<CR>", "blame" },
    b = { ":Telescope git_branches<CR>", "branches" },
    B = { ":GBrowse<CR>", "browse" },
    c = {
      name = "Commits",
      c = { ":Git commit<CR>", "commit" },
      o = { ":Telescope git_commits<CR>", "checkout commit" },
      u = { ":Telescope git_bcommits<CR>", "checkout commit(for current file)" },
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
    S = { ":Telescope git_status<CR>", "status" },
    t = { ":GitGutterSignsToggle<CR>", "toggle signs" },
    u = { ":lua require('gitsigns').undo_stage_hunk()<CR>", "undo stage hunk" },
  },

  -- l is for LSP
  l = {
    name = "LSP",
    -- a = { ":Lspsaga code_action<CR>", "code actions" },
    -- A = { ":Lspsaga range_code_action<CR>", "selected action" },
    b = { ":lua require('plugins.configs.telescope').cur_buf_symbols()<CR>", "cur buf symbols" },
    d = { ":Trouble lsp_document_diagnostics<CR>", "document diagnostics" },
    D = { ":Trouble lsp_workspace_diagnostics<CR>", "workspace diagnostics" },
    f = { ":lua vim.lsp.buf.formatting()<CR>", "format" },
    h = { ":lua vim.lsp.buf.signature_help()<CR>", "signature_help" },
    I = { ":LspInfo<CR>", "lsp info" },
    -- l = { ":Lspsaga lsp_finder<CR>", "lsp finder" },
    o = { ":SymbolsOutline<CR>", "outline" },
    -- p = { ":lua PeekDefinition()<CR>", "peek definition" },
    r = { ":lua require('ui.rename').rename()<CR>", "rename" },
    t = { ":lua vim.lsp.buf.type_definition()<CR>", "type defintion" },
    v = { ":LspVirtualTextToggle<CR>", "toggle virtual text" },
    s = { ":Telescope lsp_document_symbols<CR>", "document symbols" },
    S = { ":Telescope lsp_workspace_symbols<CR>", "workspace symbols" },
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
    name = "Plugin Manager",
    c = { ":lua LoadPlugins('compile')<CR>", "Compile" },
    i = { ":lua LoadPlugins('install')<CR>", "Install" },
    r = { ":luafile $MYVIMRC<CR>", "Reload" },
    s = { ":lua LoadPlugins('sync')<CR>", "Sync" },
    p = { ":lua LoadPlugins('profile')<CR>", "Profile" },
    u = { ":lua LoadPlugins('update')<CR>", "Update" },
  },

  -- q is for Quickfix
  q = {
    name = "Quickfix",
    t = { ":Trouble todo<CR>", "todos" },
    q = { ":TroubleToggle quickfix<CR>", "quickfix list" },
    l = { ":TroubleToggle loclist<CR>", "location list" },
  },

  -- r is for Run
  r = {
    name = "Run",
    r = { "<Plug>SnipRun<CR>", "run the selected piece of code" },
    s = { "<Plug>SnipReset<CR>", "stop the running code" },
    c = { "<Plug>SnipClose<CR>", "clear the previous output" },
    m = { "<Plug>SnipReplMemoryClean<CR>", "clean the repl memory" },

    -- NOTE: This keybinding is only for nvim development
    e = { ":lua SaveAndExec(false)<CR>", "exec the current function (nvim devel only)" },
    E = { ":lua SaveAndExec(true)<CR>", "save and exec the current function (nvim devel only)" },
    R = { ":lua ReloadFile()<CR>", "save and reload the current file (nvim devel only)" },
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
    c = { ":Telescope git_commits<CR>", "git commits" },
    d = { ":Telescope lsp_document_diagnostics<CR>", "document diagnostics" },
    D = { ":Telescope lsp_workspace_diagnostics<CR>", "workspace diagnostics" },
    e = { ":Telescope symbols<CR>", "emojis" },
    f = { ":Telescope fzf_writer files<CR>", "files" },
    F = { ":Telescope git_files<CR>", "git files" },
    g = { ":Telescope fzf_writer staged_grep<CR>", "text" },
    G = { ":lua require('plugins.configs.telescope').grep_current_buf()<CR>", "grep cur buf" },
    i = { ":Telescope media_files<CR>", "media files" },
    l = { ":Telescope loclist<CR>", "loclist" },
    m = { ":Telescope marks<CR>", "marks" },
    o = { ":Telescope oldfiles<CR>", "oldfiles" },
    p = { ":Telescope project<CR>", "projects" },
    S = { ":Telescope git_status<CR>", "git status" },
    t = { ":TodoTelescope<CR>", "todos" },
    r = { ":Telescope registers<CR>", "registers" },
    R = { ":Telescope reloader<CR>", "reloader" },
    w = { ":Telescope file_browser<CR>", "file browser" },
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
    p = { ":TSPlaygroundToggle<CR>", "toggle playground" },
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
    f = { ":lua TermToggle('floating')<CR>", "floating" },
    t = { ":lua TermToggle()<CR>", "toggle" },
    s = { ":lua TermSend()<CR>", "send content" },
  },
}

-- Mode specific changes
local normalMappings = vim.deepcopy(mappings)

local visualMappings = vim.deepcopy(mappings)
visualMappings["/"][1] = "<Plug>kommentary_visual_default"

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

function plugin.keymaps()
  -- Set leader
  vim.api.nvim_set_keymap("n", "<Space>", "<NOP>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("v", "<Space>", "<NOP>", { noremap = true, silent = true })
  vim.g.mapleader = " "

  wk.register(normalMappings, getOpts("n"))
  wk.register(visualMappings, getOpts("v"))

  wk.register(getBracketMappings(true, true), getOpts("n", "]"))
  wk.register(getBracketMappings(true, false), getOpts("n", "]"))
  wk.register(getBracketMappings(false, true), getOpts("n", "["))
  wk.register(getBracketMappings(false, false), getOpts("n", "["))

  -- LSP Bindings
  wk.register({
    d = { ":lua vim.lsp.diagnostic.goto_prev({ popup_opts = { border = 'rounded' } })<CR>", "Previous Diagnostic" },
    r = "Goto previous usage", -- Defined in treesitter config
  }, getOpts(
    "n",
    "["
  ))
  wk.register({
    d = { ":lua vim.lsp.diagnostic.goto_next({ popup_opts = { border = 'rounded' } })<CR>", "Next  Diagnostic" },
    r = "Goto next usage", -- Defined in treesitter config
  }, getOpts(
    "n",
    "]"
  ))
  wk.register({
    d = { ":lua vim.lsp.buf.definition()<CR>", "Goto definition" },
    D = { ":lua vim.lsp.buf.declaration()<CR>", "Goto declaration" },
    I = { ":lua vim.lsp.buf.implementation()<CR>", "Goto implementation" },
    l = { ":lua vim.lsp.diagnostic.show_line_diagnostics({ border = 'rounded' })<CR>", "Show line diagnostics" },
    r = { ":TroubleToggle lsp_references<CR>", "Goto references" },
    -- p = { ":lua preview_definition<CR>", "Preview definition" },
  }, getOpts(
    "n",
    "g"
  ))
end

function plugin.defineAugroups()
  -- Hide the status line for the which-key window
  require("utils").DefineAugroups({
    which_key = {
      { "FileType", "which_key", "set laststatus=0 noshowmode noruler" },
      { "BufLeave", "<buffer>", "set laststatus=2 noshowmode ruler" },
    },
  })
end

return plugin
