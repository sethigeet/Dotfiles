local function cmd(c, isPlugin)
  local prefix = isPlugin and "<Plug>" or "<Cmd>"
  local suffix = isPlugin and "" or "<CR>"
  return prefix .. c .. suffix
end

local mappings = {
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
        function() require("dapui").float_element("breakpoints") end,
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
      function() require("dapui").float_element("stacks") end,
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
}

return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = {
        presets = {
          operators = false,
          motions = false,
        },
      },
      icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = " ", -- symbol prepended to a group
      },

      spec = {
        {
          mode = { "n", "v" },
          -- Add icons and group names
          { "<leader>u", icon = "󰕌" },
          { "<leader>e", icon = "󰙅" },
          { "<leader>s", group = "Search", icon = "" },
          { "[", group = "Prev" },
          { "]", group = "Next" },
          { "g", group = "Goto" },
          { "gs", group = "Surround" },
          { "<leader>t", group = "Treesitter", icon = "" },
          { "<leader>g", group = "Git" },
          { "<leader>gr", group = "Reset" },
          { "<leader>gs", group = "Stage" },

          {
            "<leader>b",
            group = "Buffer",
            expand = function() return require("which-key.extras").expand.buf() end,
          },
          {
            "<leader>w",
            group = "Windows",
            proxy = "<c-w>",
            expand = function() return require("which-key.extras").expand.win() end,
          },

          -- better descriptions
          { "gx", desc = "Open with system app" },

          -- Custom `g` mappings
          {
            "gl",
            function() vim.diagnostic.open_float({ scope = "line", header = "Line Diagnostics", source = true }) end,
            desc = "Show line diagnostics",
          },
          {
            "gs",
            function() vim.lsp.buf.signature_help({ border = "rounded" }) end,
            desc = "Show signature help",
          },

          -- Custom `]` and `[` mappings
          { "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, desc = "Previous diagnostic" },
          { "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, desc = "Next diagnostic" },
          { "[q", cmd("cprev"), desc = "Previous quickfix list item" },
          { "]q", cmd("cnext"), desc = "Next quickfix list item" },
          { "[l", cmd("lnext"), desc = "Previous loclist list item" },
          { "]l", cmd("lnext"), desc = "Next loclist item" },

          -- Other custom mappings
          -- `l` is for LSP
          { "<leader>l", group = "LSP", icon = { icon = "󰷫", color = "purple" } },
          { "<leader>la", vim.lsp.buf.code_action, desc = "Code Actions" },
          { "<leader>lh", function() vim.lsp.buf.signature_help({ border = "rounded" }) end, desc = "Signature Help" },
          { "<leader>li", cmd("LspInfo"), desc = "LSP Info" },
          { "<leader>lr", require("lsp.helpers.rename"), desc = "Rename" },
          { "<leader>lt", vim.lsp.buf.type_definition, desc = "Type Defintion" },
          { "<leader>lv", cmd("DiagnosticVirtualTextToggle"), desc = "Toggle Virtual Text" },

          -- `g` is for git
          { "<leader>gd", cmd("DiffviewOpen"), desc = "Diff" },
        },

        {
          mode = { "v" },
          { "<leader>p", '"_dP', desc = "Paste without yank" },
        },
      },
    },
  },
}
