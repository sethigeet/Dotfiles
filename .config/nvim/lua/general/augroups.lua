local DefineAugroups = require("utils").DefineAugroups

local augroups = {
  general_settings = {
    {
      "TextYankPost",
      "*",
      'lua require("vim.highlight").on_yank({higroup = "IncSearch", timeout = 500})',
    },
    { "BufWinEnter", "*.*", "silent!", "loadview" }, -- Save the state for the next time
    { "BufWinLeave", "*.*", "mkview" }, -- Save the state for the next time
  },
  auto_compile = {},

  filetypes = {
    { "BufRead,BufNewFile", "*.{jsx,js}", "setlocal filetype=javascriptreact" },
    { "BufRead,BufNewFile", "*.{tsx}", "setlocal filetype=typescriptreact" },
  },
}

DefineAugroups(augroups)
