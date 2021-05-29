-- Post install command: nvim --headless "+call firenvim#install(0) | q"
--
local DefineAugroups = require("general.functions").DefineAugroups

DefineAugroups({
    FireNVIM = {
        { "BufEnter", "github.com_*.txt", "set filetype=markdown" },
        { "BufEnter", "*graphql*.txt", "set filetype=graphql" }
    }
})

local firenvim_config = {}

-- Global Settings
firenvim_config["globalSettings"] = { ["alt"] = "all" }

-- Local Settings
firenvim_config["localSettings"] = {
    [".*"] = {
        ["cmdline"] = "neovim",
        ["content"] = "text",
        ["priority"] = 0,
        ["selector"] = "textarea",
        ["takeover"] = "always"
    },
    ["https?://twitter.com/"] = { ["takeover"] = "never", ["priority"] = 1 }
}

vim.g.firenvim_config = firenvim_config
