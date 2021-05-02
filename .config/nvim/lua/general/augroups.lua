local define_augroups = require("general.functions").define_augroups

define_augroups({
    general_settings = {
        {
            "TextYankPost", "*",
            "lua require(\"vim.highlight\").on_yank({higroup = \"IncSearch\", timeout = 500})"
        }, { "BufWinEnter", "*", "setlocal formatoptions-=c formatoptions-=r formatoptions-=o" },
        { "BufRead", "*", "setlocal formatoptions-=c formatoptions-=r formatoptions-=o" },
        { "BufNewFile", "*", "setlocal formatoptions-=c formatoptions-=r formatoptions-=o" },
        { "BufWinEnter", "*.*", "silent!", "loadview" }, -- Save the state for the next time
        { "BufWinLeave", "*.*", "mkview" }, -- Save the state for the next time
        -- Center the screen when entering insert mode
        { "InsertEnter", "*", "norm zzi" }
    },
    auto_compile = {
        -- Automatically source the vimrc when updated
        { "BufWritePost", "$MYVIMRC", "luafile %" },
        -- Automatically install plugins when the plugins file is updated
        { "BufWritePost", "plugins.lua", "PackerCompile" }
    },
    detect_ft = { { "BufEnter", "*.rasi", "set ft=css" } }
})
