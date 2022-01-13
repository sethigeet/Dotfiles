local map = require("utils").map

-- Better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Better nav for omnicomplete
map("i", "<C-j>", [[("\<C-n>")]], { expr = true })
map("i", "<C-k>", [[("\<C-p>")]], { expr = true })

-- Easy CAPS
map("i", "<M-u>", "<Esc>viwUi")
map("n", "<M-u>", "viwU<Esc>")

-- Center the screen after search
map("n", "n", "nzzzv", { remap = true })
map("n", "N", "Nzzzv", { remap = true })

-- Keep the cursor where it was after `J`
map("n", "J", "mzJ`z")

-- Substitute command shortcut
map("n", "<M-x>", ":%s//g<Left><Left>")
map("v", "<M-x>", ":s//g<Left><Left>")

-- Delete wihthout yanking
map("n", "<M-d>", 'V"_d')
map("v", "<M-d>", '"_d')
