local DefineAugroups = require("utils").DefineAugroups

local augroups = {
  general_settings = {
    {
      "TextYankPost",
      "*",
      'lua require("vim.highlight").on_yank({higroup = "IncSearch", timeout = 500})',
    },

    -- Get back to the place from where you left the file
    --  Builtin vim way:
    -- { "BufWinEnter", "*.*", "silent!", "loadview" }, -- Load the state save state
    -- { "BufWinLeave", "*.*", "mkview" }, -- Save the state for the next time
    -- Custom implementation to not interfere with plugins
    { "BufReadPost", "*", "lua require('utils').restoreLastPlace()" },
  },
  auto_compile = {},

  filetypes = {
    { "BufRead,BufNewFile", "*.{jsx,js}", "setlocal filetype=javascriptreact" },
    { "BufRead,BufNewFile", "*.{tsx}", "setlocal filetype=typescriptreact" },
  },
}

DefineAugroups(augroups)
