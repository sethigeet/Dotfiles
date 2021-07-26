local map = require("utils.map")

-- Better indenting
map.vnoremap("<", "<gv")
map.vnoremap(">", ">gv")

-- Better nav for omnicomplete
map.inoremap("<C-j>", [[("\<C-n>")]], { expr = true })
map.inoremap("<C-k>", [[("\<C-p>")]], { expr = true })

-- Easy CAPS
map.inoremap("<M-u>", "<Esc>viwUi")
map.nnoremap("<M-u>", "viwU<Esc>")

-- Center the screen after search
map.nnoremap("n", "nzzzv")
map.nnoremap("N", "Nzzzv")

-- Substitute command shortcut
map.nnoremap("S", ":%s//g<Left><Left>")
map.vnoremap("S", ":s//g<Left><Left>")
