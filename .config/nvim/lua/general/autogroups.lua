local define_augroups = require("general.functions")

define_augroups({
    _general_settings = {
        {
            "TextYankPost", "*",
            'lua require("vim.highlight").on_yank({higroup = "IncSearch", timeout = 200})'
        }, {
            "BufWinEnter", "*",
            "setlocal formatoptions-=c formatoptions-=r formatoptions-=o"
        },
        {
            "BufRead", "*",
            "setlocal formatoptions-=c formatoptions-=r formatoptions-=o"
        }, {
            "BufNewFile", "*",
            "setlocal formatoptions-=c formatoptions-=r formatoptions-=o"
        }, {"BufWinEnter", "*.*", "silent!", "loadview"}, -- Save the state for the next time
        {"BufWinLeave", "*.*", "mkview"}, -- Save the state for the next time
        {"FileType", "markdown", "set wrap"},
        -- set the timeout length for mappings         By default timeoutlen=1000
        {"InsertEnter", "*", "set timeoutlen=1000"},
        {"InsertLeave", "*", "set timeoutlen=100"}
    }
})
