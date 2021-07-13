local DefineAugroups = require("general.functions").DefineAugroups

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
}

if Opts.editor.smart_relative_line_numbers then
  augroups["mode_switching "] = {
    {
      "InsertEnter",
      "*",
      "if &relativenumber | let g:ms_relativenumberoff = 1 | setlocal number norelativenumber | endif",
    },
    { "InsertLeave", "*", 'if exists("g:ms_relativenumberoff") | setlocal relativenumber | endif' },
    { "InsertEnter", "*", "if &cursorline | let g:ms_cursorlineoff = 1 | setlocal nocursorline | endif" },
    { "InsertLeave", "*", 'if exists("g:ms_cursorlineoff") | setlocal cursorline | endif' },
  }
end

DefineAugroups(augroups)
