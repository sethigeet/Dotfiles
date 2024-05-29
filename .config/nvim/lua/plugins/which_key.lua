local function get_opts(mode, prefix)
  local actual_prefix
  if prefix then
    actual_prefix = prefix
  else
    actual_prefix = "<leader>"
  end

  return {
    mode = mode,
    prefix = actual_prefix,
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = false,
  }
end

local function cmd(c, isPlugin)
  local prefix = isPlugin and "<Plug>" or "<Cmd>"
  local suffix = isPlugin and "" or "<CR>"
  return prefix .. c .. suffix
end

local mappings = {
  b = { name = "Buffer" },
  C = { name = "Colors" },
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
            if not (message and #message > 0) then return end
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
            if not (condition and #condition > 0) then return end
            require("dap").set_breakpoint(condition)
          end)
        end,
        "set conditional breakpoint",
      },
      L = {
        function() require("dapui").float_element("breakpoints", {}) end,
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
      function() require("dapui").float_element("stacks", {}) end,
      "show stacks",
    },
    d = {
      function() require("dap").disconnect({ terminateDebugee = false }) end,
      "disconnect",
    },
    t = { require("dapui").toggle, "Toggle UI" },
    T = {
      function() require("dap").disconnect({ terminateDebugee = true }) end,
      "terminate & disconnect",
    },
  },
  D = { name = "Database" },
  g = {
    name = "Git",
    d = { cmd("DiffviewOpen"), "diff" },
    r = { name = "Reset" },
    s = { name = "Stage" },
  },
  -- l is for LSP
  l = {
    name = "LSP",
    a = { vim.lsp.buf.code_action, "code actions" },
    A = { vim.lsp.buf.range_code_action, "range code actions" },
    f = {
      function() vim.lsp.buf.format({ async = true }) end,
      "format",
    },
    h = { vim.lsp.buf.signature_help, "signature_help" },
    i = { cmd("LspInfo"), "lsp info" },
    p = {
      name = "Peek",
      d = { function() require("lsp.helpers.peek").peek("definition") end, "definition" },
      t = { function() require("lsp.helpers.peek").peek("typeDefinition") end, "type definition" },
      i = { function() require("lsp.helpers.peek").peek("implementation") end, "implementation" },
    },
    r = { require("lsp.helpers.rename"), "rename" },
    t = { vim.lsp.buf.type_definition, "type defintion" },
    v = { cmd("DiagnosticVirtualTextToggle"), "toggle virtual text" },
  },
  q = { name = "Quickfix" },
  r = { name = "Run" },
  s = { name = "Search" },
  t = { name = "Treesitter" },
}

local open_bracket_mappings = {
  d = { vim.diagnostic.goto_prev, "Previous diagnostic" },
  q = { cmd("cprev"), "Previous quickfix list item" },
}
local close_bracket_mappings = {
  d = { vim.diagnostic.goto_next, "Next diagnostic" },
  q = { cmd("cnext"), "Next quickfix list item" },
}

local g_mappings = {
  d = { vim.lsp.buf.definition, "Goto definition" },
  D = { vim.lsp.buf.declaration, "Goto declaration" },
  I = { vim.lsp.buf.implementation, "Goto implementation" },
  l = {
    function() vim.diagnostic.open_float({ scope = "line", header = "Line Diagnostics", source = true }) end,
    "Show line diagnostics",
  },
  p = { function() require("lsp.helpers.peek").peek("definition") end, "Peek definition" },
  s = { vim.lsp.buf.signature_help, "Goto references" },
}

-- Mode specific changes
local normal_mappings = vim.deepcopy(mappings)

local visual_mappings = vim.deepcopy(mappings)
visual_mappings["p"] = { '"_dP', "Paste without yank" }

return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = {
        spelling = {
          enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
        },
        presets = {
          operators = false, -- adds help for operators like d, y, ...
          motions = false, -- adds help for motions
          text_objects = false, -- help for text objects triggered after entering an operator
        },
      },
      icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = " ", -- symbol prepended to a group
      },
      window = {
        margin = { 1, 0, 0, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 1, 1, 1, 1 }, -- extra window padding [top, right, bottom, left]
      },
      layout = {
        height = { min = 5, max = 15 }, -- min and max height of the columns
        width = { min = 4, max = 50 }, -- min and max width of the columns
      },
    },
    init = function()
      local wk = require("which-key")

      vim.g.mapleader = " "

      -- `Leader` key
      wk.register(normal_mappings, get_opts("n"))
      wk.register(visual_mappings, get_opts("v"))

      -- bracket keys
      wk.register(open_bracket_mappings, get_opts("n", "["))
      wk.register(close_bracket_mappings, get_opts("n", "]"))

      -- `g` key
      wk.register(g_mappings, get_opts("n", "g"))
    end,
  },
}
