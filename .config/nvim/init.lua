require("general")
require("keymappings")
require("plugins")

-- TODO: fix this!
vim.cmd("source " .. vim.fn.stdpath("config") ..
            "/lua/plugins/configs/whichkey.vim")

