local wk = require("which-key")
local Plugin = require("plugins.plugin")

local PICKERS = require("telescope.builtin")
local CUSTOM_PICKERS = require("plugins.configs.telescope").utils
local MENUS = require("plugins.configs.hydra").utils

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

local function cmd(c, isPlugin)
  local prefix = isPlugin and "<Plug>" or "<Cmd>"
  local suffix = isPlugin and "" or "<CR>"
  return prefix .. c .. suffix
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
  ["?"] = { cmd("NvimTreeFindFile"), "show file in tree" },
  [";"] = { cmd("Alpha"), "show start screen" },
  e = { cmd("NvimTreeToggle"), "explorer" },
  f = { CUSTOM_PICKERS.find_files, "find files" },
  o = { MENUS.options, "options" },
  u = { cmd("UndotreeToggle"), "undo tree" },

  -- b is for Buffer
  b = {
    name = "Buffer",
    d = { cmd("Bdelete"), "delete buffer" },
    f = { PICKERS.buffers, "search buffers" },
    j = { cmd("BufferLineCyclePrev"), "previous buffer" },
    k = { cmd("BufferLineCycleNext"), "next buffer" },
    h = { cmd("BufferLineCloseRight"), "close right buffer" },
    l = { cmd("BufferLineCloseLeft"), "close left buffer" },
    H = { cmd("BufferLineMovePrev"), "move to previous" },
    L = { cmd("BufferLineMoveNext"), "move to next" },
    p = { cmd("BufferLinePick"), "pick buffer" },
    s = {
      name = "Sort",
      d = { cmd("BufferLineSortByDirectory"), "by directory" },
      e = { cmd("BufferLineSortByExtension"), "by extension" },
      r = { cmd("BufferLineSortByRelativeDirector"), "by relative directory" },
    },
  },

  C = {
    name = "Convert Color",
    p = { cmd("Colortils picker"), "open picker" },
    l = { cmd("Colortils lighten"), "lighten" },
    d = { cmd("Colortils darken"), "darken" },
    g = { cmd("Colortils gradient"), "gradient" },
    G = { cmd("Colortils greyscale"), "greyscale" },
    c = { cmd("Colortils css list"), "list css colors" },
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
          require("dapui").float_element("breakpoints", {})
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
        require("dapui").float_element("stacks", {})
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
    t = { cmd("DBUIToggle"), "toggle ui" },
    f = { cmd("DBUIFindBuffer"), "find buffer" },
    r = { cmd("DBUIRenameBuffer"), "rename buffer" },
    i = { cmd("DBUILastQueryInfo"), "last query info" },
  },

  -- g is for Git
  g = {
    name = "Git",
    b = { PICKERS.git_branches, "branches" },
    c = {
      name = "Commits",
      c = { cmd("Neogit commit"), "commit" },
      o = { PICKERS.git_commits, "checkout commit" },
      u = { PICKERS.git_bcommits, "checkout commit(for current file)" },
    },
    d = { cmd("DiffviewOpen"), "diff" },
    D = { cmd("Gitsigns preview_hunk"), "inline diff" },
    g = { cmd("Neogit"), "neogit" },
    j = { cmd("Gitsigns next_hunk"), "next hunk" },
    k = { cmd("Gitsigns prev_hunk"), "prev hunk" },
    m = { cmd("GitMessenger"), "message" },
    r = {
      name = "Reset",
      b = { cmd("Gitsigns reset_buffer"), "buffer" },
      h = { cmd("Gitsigns reset_hunk"), "hunk" },
    },
    s = {
      name = "Stage",
      b = { cmd("Gitsigns stage_buffer"), "buffer" },
      h = { cmd("Gitsigns stage_hunk"), "hunk" },
      u = { cmd("Gitsigns undo_stage_hunk"), "undo hunk" },
    },
    S = { PICKERS.git_status, "status" },
    t = { cmd("Gitsigns toggle_signs"), "toggle signs" },
  },

  -- l is for LSP
  l = {
    name = "LSP",
    a = { vim.lsp.buf.code_action, "code actions" },
    A = { vim.lsp.buf.range_code_action, "range code actions" },
    b = { CUSTOM_PICKERS.cur_buf_symbols, "cur buf symbols" },
    d = { cmd("Trouble document_diagnostics"), "document diagnostics" },
    D = { cmd("Trouble workspace_diagnostics"), "workspace diagnostics" },
    f = {
      function()
        vim.lsp.buf.format({ async = true })
      end,
      "format",
    },
    h = { vim.lsp.buf.signature_help, "signature_help" },
    i = { cmd("LspInfo"), "lsp info" },
    I = { cmd("Mason"), "lsp install info" },
    o = { cmd("SymbolsOutline"), "outline" },
    p = {
      name = "Peek",
      d = { cmd("lua require('lsp.helpers.peek').peek('definition')"), "definition" },
      t = { cmd("lua require('lsp.helpers.peek').peek('typeDefinition')"), "type definition" },
      i = { cmd("lua require('lsp.helpers.peek').peek('implementation')"), "implementation" },
    },
    r = { require("lsp.helpers.rename"), "rename" },
    t = { vim.lsp.buf.type_definition, "type defintion" },
    v = { cmd("DiagnosticVirtualTextToggle"), "toggle virtual text" },
    s = { PICKERS.lsp_document_symbols, "document symbols" },
    S = { PICKERS.lsp_workspace_symbols, "workspace symbols" },
  },

  p = {
    name = "Plugin Manager",
    c = { cmd("lua LoadPlugins('compile')"), "compile" },
    i = { cmd("lua LoadPlugins('install')"), "install" },
    r = { cmd("luafile $MYVIMRC"), "reload" },
    s = { cmd("lua LoadPlugins('sync')"), "sync" },
    p = { cmd("lua LoadPlugins('profile')"), "profile" },
    u = { cmd("lua LoadPlugins('update')"), "update" },
  },

  -- q is for Quickfix
  q = {
    name = "Quickfix",
    t = { cmd("Trouble todo"), "todos" },
    q = { cmd("TroubleToggle quickfix"), "quickfix list" },
    l = { cmd("TroubleToggle loclist"), "location list" },
  },

  -- r is for Run
  r = {
    name = "Run",
    -- NOTE: This keybinding is only for nvim development
    e = { cmd("lua SaveAndExec(false)"), "exec the current function (nvim devel only)" },
    E = { cmd("lua SaveAndExec(true)"), "save and exec the current function (nvim devel only)" },
    R = { cmd("lua ReloadFile()"), "save and reload the current file (nvim devel only)" },
  },

  -- s is for Search
  s = {
    name = "Search",
    ["."] = { PICKERS.filetypes, "filetypes" },
    [";"] = { PICKERS.commands, "commands" },
    A = { PICKERS.builtin, "all" },
    b = { PICKERS.buffers, "buffers" },
    B = { PICKERS.git_branches, "git branches" },
    c = { PICKERS.git_commits, "git commits" },
    d = {
      function()
        PICKERS.diagnostics({ bufnr = 0 })
      end,
      "document diagnostics",
    },
    D = { PICKERS.diagnostics, "workspace diagnostics" },
    e = { PICKERS.symbols, "emojis" },
    f = { PICKERS.find_files, "files" },
    F = { PICKERS.git_files, "git files" },
    g = { PICKERS.live_grep, "text" },
    G = { CUSTOM_PICKERS.grep_current_buf, "grep cur buf" },
    l = { PICKERS.loclist, "loclist" },
    m = { PICKERS.marks, "marks" },
    o = { PICKERS.oldfiles, "oldfiles" },
    -- p = { get_cmd("Telescope projects"), "projects" },
    r = { PICKERS.resume, "resume last" },
    R = { PICKERS.registers, "registers" },
    s = { CUSTOM_PICKERS.grep_selected_text, "grep selected text" },
    S = { PICKERS.git_status, "git status" },
    t = { cmd("TodoTelescope"), "todos" },
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
    p = { cmd("TSPlaygroundToggle"), "toggle playground" },
    s = { MENUS.swap, "swap" },
  },

  -- T is for Terminal
  T = {
    name = "Terminal",
    f = { cmd("lua TermToggle('floating')"), "floating" },
    t = { cmd("lua TermToggle()"), "toggle" },
    s = { cmd("lua TermSend()"), "send content" },
  },
}

local open_bracket_mappings = {
  d = { vim.diagnostic.goto_prev, "Previous Diagnostic" },
  q = { cmd("cprev"), "Previous Quickfix List Item" },
  r = "Goto previous usage", -- Defined in treesitter config
  g = { cmd("Gitsigns prev_hunk"), "Prev Hunk" },
}
local close_bracket_mappings = {
  d = { vim.diagnostic.goto_next, "Next  Diagnostic" },
  q = { cmd("cnext"), "Next Quickfix List Item" },
  r = "Goto next usage", -- Defined in treesitter config
  g = { cmd("Gitsigns next_hunk"), "Next Hunk" },
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
    cmd("lua vim.diagnostic.open_float(0, { scope = 'line', header = 'Line Diagnostics', source = true })"),
    "Show line diagnostics",
  },
  p = { cmd("lua require('lsp.helpers.peek').peek('definition')"), "Peek definition" },
  r = { cmd("TroubleToggle lsp_references"), "Goto references" },
  s = { vim.lsp.buf.signature_help, "Goto references" },
}

-- Mode specific changes
local normal_mappings = vim.deepcopy(mappings)

local visual_mappings = vim.deepcopy(mappings)
visual_mappings["/"][1] = "<Esc><Cmd>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>"
visual_mappings["p"] = { '"_dP', "Paste without yank" }
visual_mappings["s"]["s"] = {
  function()
    CUSTOM_PICKERS.grep_selected_text("v")
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
