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
})
