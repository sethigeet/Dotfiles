require("plugins")
require("keymappings")
require("general")

-- TODO: fix this!
vim.cmd("source " .. vim.fn.stdpath("config") ..
            "/lua/plugins/configs/whichkey.vim")

