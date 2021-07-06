local DefineAugroups = require("general.functions").DefineAugroups

DefineAugroups({
  general_settings = {
    {
      "TextYankPost",
      "*",
      'lua require("vim.highlight").on_yank({higroup = "IncSearch", timeout = 500})',
    },
    { "BufWinEnter", "*", "setlocal formatoptions-=c formatoptions-=r formatoptions-=o" },
    { "BufRead", "*", "setlocal formatoptions-=c formatoptions-=r formatoptions-=o" },
    { "BufNewFile", "*", "setlocal formatoptions-=c formatoptions-=r formatoptions-=o" },
    { "BufWinEnter", "*.*", "silent!", "loadview" }, -- Save the state for the next time
    { "BufWinLeave", "*.*", "mkview" }, -- Save the state for the next time
  },
  auto_compile = {
    -- Automatically source the vimrc when updated
    { "BufWritePost", "$MYVIMRC", "luafile %" },
    -- Automatically install plugins when the plugins file is updated
    { "BufWritePost", "plugins.lua", "PackerCompile" },
  },
  detect_ft = { { "BufEnter", "*.rasi", "set ft=css" }, { "BufEnter", "*.gql", "set ft=graphql" } },
  mode_switching = {
    -- will switch between absolute and relative line numbers depending on mode
    {
      "InsertEnter",
      "*",
      "if &relativenumber | let g:ms_relativenumberoff = 1 | setlocal number norelativenumber | endif",
    },
    { "InsertLeave", "*", 'if exists("g:ms_relativenumberoff") | setlocal relativenumber | endif' },
    { "InsertEnter", "*", "if &cursorline | let g:ms_cursorlineoff = 1 | setlocal nocursorline | endif" },
    { "InsertLeave", "*", 'if exists("g:ms_cursorlineoff") | setlocal cursorline | endif' },
  },
})
