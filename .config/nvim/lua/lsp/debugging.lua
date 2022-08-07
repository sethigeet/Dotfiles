local debugging = {}

function debugging.setup()
  -- Setup DAP
  local dap, dapui = require("dap"), require("dapui")
  dap.defaults.fallback.terminal_win_cmd = "50vsplit new"
  dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
  dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
  dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

  require("utils.wrappers").define_augroups({
    dap_repl = {
      -- { "FileType", "dap-repl", cb = require("dap.ext.autocompl").attach },
    },
  })

  -- Setup DAP-UI
  dapui.setup({
    mappings = {
      -- Use a table to apply multiple mappings
      expand = { "<CR>", "<2-LeftMouse>", "l" },
      open = { "o", "<CR>" },
      remove = "d",
      edit = "e",
      repl = "r",
    },
    layout = {
      {
        elements = {
          { id = "scopes", size = 0.5 },
          { id = "breakpoints", size = 0.25 },
          { id = "watches", size = 0.25 },
        },
        size = 40,
        position = "left",
      },

      {
        elements = { "repl" },
        size = 10,
        position = "bottom",
      },
    },
    floating = {
      max_height = 15, -- These can be integers or a float between 0 and 1.
      max_width = 40, -- Floats will be treated as percentage of your screen.
      border = "rounded", -- Border style. Can be "single", "double" or "rounded"
      mappings = {
        close = { "q", "<Esc>" },
      },
    },
    windows = { indent = 1 },
  })

  -- Setup keymaps
  debugging.keymaps()
end

function debugging.keymaps()
  local map = require("utils.wrappers").map

  map("n", "<F5>", require("dap").continue)
  map("n", "<F6>", require("dap").step_over)
  map("n", "<F7>", require("dap").step_into)
  map("n", "<F8>", require("dap").disconnect)
end

return debugging
