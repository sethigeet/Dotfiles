local wk = require("which-key")
local Plugin = require("plugins.plugin")

local function get_opts(mode, prefix)
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

local function get_cmd(cmd, isPlugin)
  local prefix = isPlugin and "<Plug>" or "<Cmd>"
  local suffix = isPlugin and "" or "<CR>"
  return prefix .. cmd .. suffix
end

-- Treesitter move plugin keybindings
local function get_bracket_mappings(next, start)
  local dir = next and "next" or "previous"
  local towards = start and "start" or "end"

  local bracket_mappings = {
    f = "goto " .. dir .. " function " .. towards,
    c = "goto " .. dir .. " class " .. towards,
    l = "goto " .. dir .. " loop " .. towards,
    i = "goto " .. dir .. " conditional " .. towards,
    p = "goto " .. dir .. " parameter " .. towards,
    b = "goto " .. dir .. " block " .. towards,
  }

  local actual_bracket_mappings = {}
  for key, obj in pairs(bracket_mappings) do
    local actual_key = start and key or string.upper(key)
    actual_bracket_mappings[string.format("%s", actual_key)] = obj
  end

  return actual_bracket_mappings
end

local mappings = {
  ["/"] = { "<Cmd>lua require('Comment.api').call('toggle_current_linewise_op')<CR>g@$", "comment" },
  ["?"] = { get_cmd("NvimTreeFindFile"), "show file in tree" },
  ["="] = { "<C-W>=", "balance windows" },
  [";"] = { get_cmd("Dashboard"), "show start screen" },
  e = { get_cmd("NvimTreeToggle"), "explorer" },
  f = { require("plugins.configs.telescope").utils.find_files, "find files" },
  h = { "<C-W>s", "split below" },
  M = { get_cmd("MarkdownPreviewToggle"), "markdown preview" },
  u = { get_cmd("UndotreeToggle"), "undo tree" },
  v = { "<C-W>v", "split right" },
  w = { get_cmd("w"), "save file" },
  z = { get_cmd("ZenMode"), "toggle zen mode" },

  -- a is for Action
  a = {
    name = "Actions",
    c = { get_cmd("ColorizerToggle"), "colorizer" },
    h = { get_cmd("nohl"), "remove search highlight" },
    i = { get_cmd("IndentBlanklineToggle"), "toggle indent lines" },
    n = { get_cmd("set nonumber!"), "line-numbers" },
    r = { get_cmd("set norelativenumber!"), "relative line nums" },
    v = { get_cmd("Codi"), "virtual repl on" },
    V = { get_cmd("Codi!"), "virtual repl off" },
    w = { get_cmd("set wrap!"), "word wrap" },
  },

  -- b is for Buffer
  b = {
    name = "Buffer",
    d = { get_cmd("Bdelete"), "delete buffer" },
    f = { get_cmd("Telescope buffers"), "search buffers" },
    j = { get_cmd("BufferLineCyclePrev"), "previous buffer" },
    k = { get_cmd("BufferLineCycleNext"), "next buffer" },
    h = { get_cmd("BufferLineCloseRight"), "close right buffer" },
    l = { get_cmd("BufferLineCloseLeft"), "close left buffer" },
    H = { get_cmd("BufferLineMovePrev"), "move to previous" },
    L = { get_cmd("BufferLineMoveNext"), "move to next" },
    p = { get_cmd("BufferLinePick"), "pick buffer" },
    s = {
      name = "Sort",
      d = { get_cmd("BufferLineSortByDirectory"), "by directory" },
      e = { get_cmd("BufferLineSortByExtension"), "by extension" },
      r = { get_cmd("BufferLineSortByRelativeDirector"), "by relative directory" },
    },
  },

  C = {
    name = "Convert Color",
    c = { require("color-converter").cycle, "cycle" },
    x = { require("color-converter").to_hex, "to HEX" },
    r = { require("color-converter").to_rgb, "to RGB" },
    h = { require("color-converter").to_hsl, "to HSL" },
  },

  -- d is for Debugging
  d = {
    name = "Debugging",
    b = {
      name = "breakpoint",
      t = { require("dap").toggle_breakpoint, "toggle breakpoint" },
      l = {
        function()
          vim.ui.input({
            prompt = "Log Message for Breakpoint",
          }, function(message)
            if not (message and #message > 0) then
              return
            end
            require("dap").set_breakpoint(nil, nil, message)
          end)
        end,
        "set log breakpoint",
      },
      c = {
        function()
          vim.ui.input({
            prompt = "Condition for Breakpoint",
          }, function(condition)
            if not (condition and #condition > 0) then
              return
            end
            require("dap").set_breakpoint(condition)
          end)
        end,
        "set conditional breakpoint",
      },
      L = {
        function()
          require("dapui").float_element("breakpoints")
        end,
        "list breakpoints",
      },
    },
    c = { require("dap").continue, "start/continue" },
    C = { require("dap").run_to_cursor, "run to cursor" },
    g = { require("dap").session, "get session" },
    h = { require("dapui").eval, "hover" },
    p = { require("dap").pause, "pause" },
    q = { require("dap").close, "quit" },
    r = { require("dap").restart, "restart" },
    s = {
      name = "step",
      b = { require("dap").step_back, "step back" },
      i = { require("dap").step_into, "step into" },
      o = { require("dap").step_over, "step over" },
      u = { require("dap").step_out, "step out" },
    },
    S = {
      function()
        require("dapui").float_element("stacks")
      end,
      "show stacks",
    },
    d = {
      function()
        require("dap").disconnect({ terminateDebugee = false })
      end,
      "disconnect",
    },
    t = { require("dapui").toggle, "Toggle UI" },
    T = {
      function()
        require("dap").disconnect({ terminateDebugee = true })
      end,
      "terminate & disconnect",
    },
  },

  -- D is for Database
  D = {
    name = "Database",
    t = { get_cmd("DBUIToggle"), "toggle ui" },
    f = { get_cmd("DBUIFindBuffer"), "find buffer" },
    r = { get_cmd("DBUIRenameBuffer"), "rename buffer" },
    i = { get_cmd("DBUILastQueryInfo"), "last query info" },
  },

  -- F is for Fold
  F = {
    name = "Fold",
    O = { get_cmd("set foldlevel=20"), "open all" },
    C = { get_cmd("set foldlevel=0"), "close all" },
    c = { get_cmd("foldclose"), "close" },
    o = { get_cmd("foldopen"), "open" },
    ["1"] = { get_cmd("set foldlevel=1"), "level 1" },
    ["2"] = { get_cmd("set foldlevel=2"), "level 2" },
    ["3"] = { get_cmd("set foldlevel=3"), "level 3" },
    ["4"] = { get_cmd("set foldlevel=4"), "level 4" },
    ["5"] = { get_cmd("set foldlevel=5"), "level 5" },
    ["6"] = { get_cmd("set foldlevel=6"), "level 6" },
  },

  -- g is for Git
  g = {
    name = "Git",
    b = { get_cmd("Telescope git_branches"), "branches" },
    c = {
      name = "Commits",
      c = { get_cmd("Neogit commit"), "commit" },
      o = { get_cmd("Telescope git_commits"), "checkout commit" },
      u = { get_cmd("Telescope git_bcommits"), "checkout commit(for current file)" },
    },
    d = { get_cmd("DiffviewOpen"), "diff" },
    D = { get_cmd("Gitsigns preview_hunk"), "inline diff" },
    g = { get_cmd("Neogit"), "neogit" },
    j = { get_cmd("Gitsigns next_hunk"), "next hunk" },
    k = { get_cmd("Gitsigns prev_hunk"), "prev hunk" },
    m = { get_cmd("GitMessenger"), "message" },
    r = {
      name = "Reset",
      b = { get_cmd("Gitsigns reset_buffer"), "buffer" },
      h = { get_cmd("Gitsigns reset_hunk"), "hunk" },
    },
    s = {
      name = "Stage",
      b = { get_cmd("Gitsigns stage_buffer"), "buffer" },
      h = { get_cmd("Gitsigns stage_hunk"), "hunk" },
      u = { get_cmd("Gitsigns undo_stage_hunk"), "undo hunk" },
    },
    S = { get_cmd("Telescope git_status"), "status" },
    t = { get_cmd("GitGutterSignsToggle"), "toggle signs" },
  },

  -- l is for LSP
  l = {
    name = "LSP",
    a = { require("plugins.configs.telescope").utils.code_actions, "code actions" },
    A = {
      function()
        require("plugins.configs.telescope").code_actions(true)
      end,
      "range code actions",
    },
    b = { require("plugins.configs.telescope").utils.cur_buf_symbols, "cur buf symbols" },
    d = { get_cmd("Trouble document_diagnostics"), "document diagnostics" },
    D = { get_cmd("Trouble workspace_diagnostics"), "workspace diagnostics" },
    f = { vim.lsp.buf.formatting, "format" },
    h = { vim.lsp.buf.signature_help, "signature_help" },
    i = { get_cmd("LspInfo"), "lsp info" },
    I = { get_cmd("LspInstallInfo"), "lsp install info" },
    o = { get_cmd("SymbolsOutline"), "outline" },
    p = {
      name = "Peek",
      d = { get_cmd("lua require('lsp.helpers.peek').peek('definition')"), "definition" },
      t = { get_cmd("lua require('lsp.helpers.peek').peek('typeDefinition')"), "type definition" },
      i = { get_cmd("lua require('lsp.helpers.peek').peek('implementation')"), "implementation" },
    },
    r = { require("lsp.helpers.rename"), "rename" },
    t = { vim.lsp.buf.type_definition, "type defintion" },
    v = { get_cmd("DiagnosticVirtualTextToggle"), "toggle virtual text" },
    s = { get_cmd("Telescope lsp_document_symbols"), "document symbols" },
    S = { get_cmd("Telescope lsp_workspace_symbols"), "workspace symbols" },
  },

  -- m is for Mark
  m = {
    name = "Mark",
    a = { get_cmd("BookmarkShowAll"), "show all" },
    c = { get_cmd("BookmarkClear"), "clear" },
    d = { get_cmd("BookmarkClearAll"), "clear all" },
    j = { get_cmd("BookmarkNext"), "next mark" },
    k = { get_cmd("BookmarkPrev"), "prev mark" },
    l = { get_cmd("BookmarkLoad"), "load" },
    s = { get_cmd("BookmarkSave"), "save" },
    t = { get_cmd("BookmarkToggle"), "toggle" },
  },

  p = {
    name = "Plugin Manager",
    c = { get_cmd("lua LoadPlugins('compile')"), "compile" },
    i = { get_cmd("lua LoadPlugins('install')"), "install" },
    r = { get_cmd("luafile $MYVIMRC"), "reload" },
    s = { get_cmd("lua LoadPlugins('sync')"), "sync" },
    p = { get_cmd("lua LoadPlugins('profile')"), "profile" },
    u = { get_cmd("lua LoadPlugins('update')"), "update" },
  },

  -- q is for Quickfix
  q = {
    name = "Quickfix",
    t = { get_cmd("Trouble todo"), "todos" },
    q = { get_cmd("TroubleToggle quickfix"), "quickfix list" },
    l = { get_cmd("TroubleToggle loclist"), "location list" },
  },

  -- r is for Run
  r = {
    name = "Run",
    r = { get_cmd("SnipRun", true), "run the selected piece of code" },
    s = { get_cmd("SnipReset", true), "stop the running code" },
    c = { get_cmd("SnipClose", true), "clear the previous output" },
    m = { get_cmd("SnipReplMemoryClean", true), "clean the repl memory" },

    -- NOTE: This keybinding is only for nvim development
    e = { get_cmd("lua SaveAndExec(false)"), "exec the current function (nvim devel only)" },
    E = { get_cmd("lua SaveAndExec(true)"), "save and exec the current function (nvim devel only)" },
    R = { get_cmd("lua ReloadFile()"), "save and reload the current file (nvim devel only)" },
  },

  -- R is for REST Client
  R = {
    name = "REST Client",
    r = { get_cmd("RestNvim", true), "run" },
    p = { get_cmd("RestNvimPreview", true), "preview" },
  },

  -- s is for Search
  s = {
    name = "Search",
    ["."] = { get_cmd("Telescope filetypes"), "filetypes" },
    [";"] = { get_cmd("Telescope commands"), "commands" },
    a = { vim.lsp.buf.code_action, "code actions" },
    A = { get_cmd("Telescope builtin"), "all" },
    b = { get_cmd("Telescope buffers"), "buffers" },
    B = { get_cmd("Telescope git_branches"), "git branches" },
    c = { get_cmd("Telescope git_commits"), "git commits" },
    d = { get_cmd("Telescope diagnostics bufnr=0"), "document diagnostics" },
    D = { get_cmd("Telescope diagnostics"), "workspace diagnostics" },
    e = { get_cmd("Telescope symbols"), "emojis" },
    f = { get_cmd("Telescope find_files"), "files" },
    F = { get_cmd("Telescope git_files"), "git files" },
    g = { get_cmd("Telescope live_grep"), "text" },
    G = { require("plugins.configs.telescope").utils.grep_current_buf, "grep cur buf" },
    i = { get_cmd("Telescope media_files"), "media files" },
    l = { get_cmd("Telescope loclist"), "loclist" },
    m = { get_cmd("Telescope marks"), "marks" },
    o = { get_cmd("Telescope oldfiles"), "oldfiles" },
    p = { get_cmd("Telescope projects"), "projects" },
    r = { get_cmd("Telescope resume"), "resume last" },
    R = { get_cmd("Telescope registers"), "registers" },
    s = { require("plugins.configs.telescope").utils.grep_selected_text, "grep selected text" },
    S = { get_cmd("Telescope git_status"), "git status" },
    t = { get_cmd("TodoTelescope"), "todos" },
  },

  -- S is for Search and replace
  S = {
    name = "Search and Replace",
    o = { require("spectre").open, "open search" },
    v = { require("spectre").open_visual, "open visual" },
    f = { require("spectre").open_file_search, "open file search" },
    a = {
      name = "Actions",
      q = "send to quickfix list",
      c = "input replace vim command",
      r = "replace all",
      o = "show options",
      v = "change view mode",
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
    p = { get_cmd("TSPlaygroundToggle"), "toggle playground" },
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
    f = { get_cmd("lua TermToggle('floating')"), "floating" },
    t = { get_cmd("lua TermToggle()"), "toggle" },
    s = { get_cmd("lua TermSend()"), "send content" },
  },
}

local open_bracket_mappings = {
  d = { vim.diagnostic.goto_prev, "Previous Diagnostic" },
  q = { get_cmd("cprev"), "Previous Quickfix List Item" },
  r = "Goto previous usage", -- Defined in treesitter config
  g = { get_cmd("Gitsigns prev_hunk"), "Prev Hunk" },
}
local close_bracket_mappings = {
  d = { vim.diagnostic.goto_next, "Next  Diagnostic" },
  q = { get_cmd("cnext"), "Next Quickfix List Item" },
  r = "Goto next usage", -- Defined in treesitter config
  g = { get_cmd("Gitsigns next_hunk"), "Next Hunk" },
}

local g_mappings = {
  b = {
    name = "Comment Block ",
    c = "Line",
  },
  c = {
    name = "Comment Line ",
    c = "Line",
    A = "Insert at the end of the line",
    o = "Insert below",
    O = "Insert above",
  },
  [">"] = {
    name = "Increase comment level",
    c = "Line",
    b = "Block",
  },
  ["<lt>"] = {
    name = "Decrease comment level",
    c = "Line",
    b = "Block",
  },
  d = { vim.lsp.buf.definition, "Goto definition" },
  D = { vim.lsp.buf.declaration, "Goto declaration" },
  I = { vim.lsp.buf.implementation, "Goto implementation" },
  l = {
    get_cmd("lua vim.diagnostic.open_float(0, { scope = 'line', header = 'Line Diagnostics', source = true })"),
    "Show line diagnostics",
  },
  p = { get_cmd("lua require('lsp.helpers.peek').peek('definition')"), "Peek definition" },
  r = { get_cmd("TroubleToggle lsp_references"), "Goto references" },
  s = { vim.lsp.buf.signature_help, "Goto references" },
}

-- Mode specific changes
local normal_mappings = vim.deepcopy(mappings)

local visual_mappings = vim.deepcopy(mappings)
visual_mappings["/"][1] = "<Esc><Cmd>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>"
visual_mappings["p"] = { '"_dP', "Paste without yank" }
visual_mappings["s"]["s"] = {
  function()
    require("plugins.configs.telescope").utils.grep_selected_text("v")
  end,
  "grep selected text",
}

return Plugin:create({
  configure = function()
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
        c = { "j", "k" },
        i = { "j", "k", "<Space>" },
      },
    })

    vim.g.mapleader = " "

    -- `Leader` key
    wk.register(normal_mappings, get_opts("n"))
    wk.register(visual_mappings, get_opts("v"))

    -- bracket keys
    wk.register(get_bracket_mappings(true, true), get_opts("n", "]"))
    wk.register(get_bracket_mappings(true, false), get_opts("n", "]"))
    wk.register(get_bracket_mappings(false, true), get_opts("n", "["))
    wk.register(get_bracket_mappings(false, false), get_opts("n", "["))
    wk.register(open_bracket_mappings, get_opts("n", "["))
    wk.register(close_bracket_mappings, get_opts("n", "]"))

    -- `g` key
    wk.register(g_mappings, get_opts("n", "g"))
  end,

  augroups = {
    which_key = {
      -- Hide the status line for the which-key window
      { "FileType", "which_key", cmd = "set laststatus=0 noshowmode noruler" },
      { "BufLeave", "<buffer>", cmd = "set laststatus=2 noshowmode ruler" },
    },
  },

  keymaps = {
    -- Set leader
    n = {
      { "<Space>", "<NOP>" },
    },
    v = {

      { "<Space>", "<NOP>" },
    },
  },
})
