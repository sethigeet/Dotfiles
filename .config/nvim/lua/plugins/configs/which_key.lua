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

local function getCmd(cmd, isPlugin)
  local prefix = isPlugin and "<Plug>" or "<Cmd>"
  local suffix = isPlugin and "" or "<CR>"
  return prefix .. cmd .. suffix
end

local mappings = {
  ["/"] = { getCmd("kommentary_line_default", true), "comment" },
  ["?"] = { getCmd("NvimTreeFindFile"), "show file in tree" },
  ["="] = { "<C-W>=", "balance windows" },
  [";"] = { getCmd("Dashboard"), "show start screen" },
  e = { getCmd("NvimTreeToggle"), "explorer" },
  f = { getCmd("Telescope fzf_writer files"), "find files" },
  h = { "<C-W>s", "split below" },
  M = { getCmd("MarkdownPreviewToggle"), "markdown preview" },
  u = { getCmd("UndotreeToggle"), "undo tree" },
  v = { "<C-W>v", "split right" },
  w = { getCmd("w"), "save file" },
  z = { getCmd("ZenMode"), "toggle zen mode" },

  -- a is for Action
  a = {
    name = "Actions",
    c = { getCmd("ColorizerToggle"), "colorizer" },
    h = { getCmd("nohl"), "remove search highlight" },
    i = { getCmd("IndentBlanklineToggle"), "toggle indent lines" },
    n = { getCmd("set nonumber!"), "line-numbers" },
    r = { getCmd("set norelativenumber!"), "relative line nums" },
    v = { getCmd("Codi"), "virtual repl on" },
    V = { getCmd("Codi!"), "virtual repl off" },
  },

  -- b is for Buffer
  b = {
    name = "Buffer",
    d = { getCmd("Bdelete"), "delete buffer" },
    f = { getCmd("Telescope buffers"), "search buffers" },
    j = { getCmd("BufferLineCyclePrev"), "previous buffer" },
    k = { getCmd("BufferLineCycleNext"), "next buffer" },
    h = { getCmd("BufferLineCloseRight"), "close right buffer" },
    l = { getCmd("BufferLineCloseLeft"), "close left buffer" },
    H = { getCmd("BufferLineMovePrev"), "move to previous" },
    L = { getCmd("BufferLineMoveNext"), "move to next" },
    p = { getCmd("BufferLinePick"), "pick buffer" },
    s = {
      name = "Sort",
      d = { getCmd("BufferLineSortByDirectory"), "by directory" },
      e = { getCmd("BufferLineSortByExtension"), "by extension" },
      r = { getCmd("BufferLineSortByRelativeDirector"), "by relative directory" },
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
    t = { getCmd("DBUIToggle"), "toggle ui" },
    f = { getCmd("DBUIFindBuffer"), "find buffer" },
    r = { getCmd("DBUIRenameBuffer"), "rename buffer" },
    i = { getCmd("DBUILastQueryInfo"), "last query info" },
  },

  -- F is for Fold
  F = {
    name = "Fold",
    O = { getCmd("set foldlevel=20"), "open all" },
    C = { getCmd("set foldlevel=0"), "close all" },
    c = { getCmd("foldclose"), "close" },
    o = { getCmd("foldopen"), "open" },
    ["1"] = { getCmd("set foldlevel=1"), "level 1" },
    ["2"] = { getCmd("set foldlevel=2"), "level 2" },
    ["3"] = { getCmd("set foldlevel=3"), "level 3" },
    ["4"] = { getCmd("set foldlevel=4"), "level 4" },
    ["5"] = { getCmd("set foldlevel=5"), "level 5" },
    ["6"] = { getCmd("set foldlevel=6"), "level 6" },
  },

  -- g is for Git
  g = {
    name = "Git",
    b = { getCmd("Telescope git_branches"), "branches" },
    c = {
      name = "Commits",
      c = { getCmd("Neogit commit"), "commit" },
      o = { getCmd("Telescope git_commits"), "checkout commit" },
      u = { getCmd("Telescope git_bcommits"), "checkout commit(for current file)" },
    },
    d = { getCmd("DiffviewOpen"), "diff" },
    g = { getCmd("Neogit"), "neogit" },
    H = { getCmd("lua require('gitsigns').preview_hunk()"), "preview hunk" },
    j = { getCmd("lua require('gitsigns').next_hunk()"), "next hunk" },
    k = { getCmd("lua require('gitsigns').prev_hunk()"), "prev hunk" },
    m = { getCmd("(git-messenger)", true), "message" },
    R = { getCmd("lua require('gitsigns').reset_hunk()"), "reset hunk" },
    s = { getCmd("lua require('gitsigns').stage_hunk()"), "stage hunk" },
    S = { getCmd("Telescope git_status"), "status" },
    t = { getCmd("GitGutterSignsToggle"), "toggle signs" },
    u = { getCmd("lua require('gitsigns').undo_stage_hunk()"), "undo stage hunk" },
  },

  -- l is for LSP
  l = {
    name = "LSP",
    a = { getCmd("lua require('plugins.configs.telescope').code_actions()"), "code actions" },
    A = { getCmd("lua require('plugins.configs.telescope').code_actions(true)"), "range code actions" },
    b = { getCmd("lua require('plugins.configs.telescope').cur_buf_symbols()"), "cur buf symbols" },
    d = { getCmd("Trouble lsp_document_diagnostics"), "document diagnostics" },
    D = { getCmd("Trouble lsp_workspace_diagnostics"), "workspace diagnostics" },
    f = { getCmd("lua vim.lsp.buf.formatting()"), "format" },
    h = { getCmd("lua vim.lsp.buf.signature_help()"), "signature_help" },
    i = { getCmd("LspInfo"), "lsp info" },
    o = { getCmd("SymbolsOutline"), "outline" },
    p = {
      name = "Peek",
      d = { getCmd("lua require('ui.peek').Peek('definition')"), "definition" },
      t = { getCmd("lua require('ui.peek').Peek('typeDefinition')"), "type definition" },
      i = { getCmd("lua require('ui.peek').Peek('implementation')"), "implementation" },
    },
    r = { getCmd("lua require('ui.rename').rename()"), "rename" },
    t = { getCmd("lua vim.lsp.buf.type_definition()"), "type defintion" },
    v = { getCmd("LspVirtualTextToggle"), "toggle virtual text" },
    s = { getCmd("Telescope lsp_document_symbols"), "document symbols" },
    S = { getCmd("Telescope lsp_workspace_symbols"), "workspace symbols" },
  },

  -- m is for Mark
  m = {
    name = "Mark",
    a = { getCmd("BookmarkShowAll"), "show all" },
    c = { getCmd("BookmarkClear"), "clear" },
    d = { ":BookmarkClearAll<CR>", "clear all" },
    j = { getCmd("BookmarkNext"), "next mark" },
    k = { getCmd("BookmarkPrev"), "prev mark" },
    l = { getCmd("BookmarkLoad"), "load" },
    s = { getCmd("BookmarkSave"), "save" },
    t = { getCmd("BookmarkToggle"), "toggle" },
  },

  p = {
    name = "Plugin Manager",
    c = { getCmd("lua LoadPlugins('compile')"), "Compile" },
    i = { getCmd("lua LoadPlugins('install')"), "Install" },
    r = { getCmd("luafile $MYVIMRC"), "Reload" },
    s = { getCmd("lua LoadPlugins('sync')"), "Sync" },
    p = { getCmd("lua LoadPlugins('profile')"), "Profile" },
    u = { getCmd("lua LoadPlugins('update')"), "Update" },
  },

  -- q is for Quickfix
  q = {
    name = "Quickfix",
    t = { getCmd("Trouble todo"), "todos" },
    q = { getCmd("TroubleToggle quickfix"), "quickfix list" },
    l = { getCmd("TroubleToggle loclist"), "location list" },
  },

  -- r is for Run
  r = {
    name = "Run",
    r = { getCmd("SnipRun", true), "run the selected piece of code" },
    s = { getCmd("SnipReset", true), "stop the running code" },
    c = { getCmd("SnipClose", true), "clear the previous output" },
    m = { getCmd("SnipReplMemoryClean", true), "clean the repl memory" },

    -- NOTE: This keybinding is only for nvim development
    e = { getCmd("lua SaveAndExec(false)"), "exec the current function (nvim devel only)" },
    E = { getCmd("lua SaveAndExec(true)"), "save and exec the current function (nvim devel only)" },
    R = { getCmd("lua ReloadFile()"), "save and reload the current file (nvim devel only)" },
  },

  -- R is for REST Client
  R = {
    name = "REST Client",
    r = { getCmd("RestNvim", true), "run" },
    p = { getCmd("RestNvimPreview", true), "preview" },
  },

  -- s is for Search
  s = {
    name = "Search",
    ["."] = { getCmd("Telescope filetypes"), "filetypes" },
    [";"] = { getCmd("Telescope commands"), "commands" },
    a = { getCmd("Telescope lsp_code_actions"), "code actions" },
    A = { getCmd("Telescope builtin"), "all" },
    b = { getCmd("Telescope buffers"), "buffers" },
    B = { getCmd("Telescope git_branches"), "git branches" },
    c = { getCmd("Telescope git_commits"), "git commits" },
    d = { getCmd("Telescope lsp_document_diagnostics"), "document diagnostics" },
    D = { getCmd("Telescope lsp_workspace_diagnostics"), "workspace diagnostics" },
    e = { getCmd("Telescope symbols"), "emojis" },
    f = { getCmd("Telescope fzf_writer files"), "files" },
    F = { getCmd("Telescope git_files"), "git files" },
    g = { getCmd("Telescope fzf_writer staged_grep"), "text" },
    G = { getCmd("lua require('plugins.configs.telescope').grep_current_buf()"), "grep cur buf" },
    i = { getCmd("Telescope media_files"), "media files" },
    l = { getCmd("Telescope loclist"), "loclist" },
    m = { getCmd("Telescope marks"), "marks" },
    o = { getCmd("Telescope oldfiles"), "oldfiles" },
    p = { getCmd("Telescope project"), "projects" },
    S = { getCmd("Telescope git_status"), "git status" },
    t = { getCmd("TodoTelescope"), "todos" },
    r = { getCmd("Telescope registers"), "registers" },
    R = { getCmd("Telescope reloader"), "reloader" },
    w = { getCmd("Telescope file_browser"), "file browser" },
  },

  -- S is for Search and replace
  S = {
    name = "Search and Replace",
    o = { getCmd("lua require('spectre').open()"), "open search" },
    v = { getCmd("lua require('spectre').open_visual()"), "open visual" },
    f = { getCmd("lua require('spectre').open_file_search()"), "open file search" },
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
    p = { getCmd("TSPlaygroundToggle"), "toggle playground" },
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
    f = { getCmd("lua TermToggle('floating')"), "floating" },
    t = { getCmd("lua TermToggle()"), "toggle" },
    s = { getCmd("lua TermSend()"), "send content" },
  },
}

-- Mode specific changes
local normalMappings = vim.deepcopy(mappings)

local visualMappings = vim.deepcopy(mappings)
visualMappings["/"][1] = "<Plug>kommentary_visual_default"
visualMappings["p"] = { '"_dP', "Paste without yank" }

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
    d = { getCmd("lua vim.lsp.diagnostic.goto_prev({ popup_opts = { border = 'rounded' } })"), "Previous Diagnostic" },
    r = "Goto previous usage", -- Defined in treesitter config
    g = { getCmd("lua require('gitsigns').prev_hunk()"), "Prev Hunk" },
  }, getOpts(
    "n",
    "["
  ))
  wk.register({
    d = { getCmd("lua vim.lsp.diagnostic.goto_next({ popup_opts = { border = 'rounded' } })"), "Next  Diagnostic" },
    r = "Goto next usage", -- Defined in treesitter config
    g = { getCmd("lua require('gitsigns').next_hunk()"), "Next Hunk" },
  }, getOpts(
    "n",
    "]"
  ))
  wk.register({
    d = { getCmd("lua vim.lsp.buf.definition()"), "Goto definition" },
    D = { getCmd("lua vim.lsp.buf.declaration()"), "Goto declaration" },
    I = { getCmd("lua vim.lsp.buf.implementation()"), "Goto implementation" },
    l = { getCmd("lua vim.lsp.diagnostic.show_line_diagnostics({ border = 'rounded' })"), "Show line diagnostics" },
    r = { getCmd("TroubleToggle lsp_references"), "Goto references" },
    p = { getCmd("lua require('ui.peek').Peek('definition')"), "Peek definition" },
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
