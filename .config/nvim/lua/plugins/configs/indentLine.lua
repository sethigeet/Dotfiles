-- vim.g.indentLine_showFirstIndentLevel = 1
-- vim.g.indentLine_fileType = ['javascript', 'c']
vim.g.indentLine_fileTypeExclude = {
    "vimwiki", "NvimTree", "help", "undotree", "diff", "startify", "git"
}
vim.g.indentLine_bufTypeExclude = {"help", "terminal"}
vim.g.indentLine_bufNameExclude = {"vifm*"}
vim.g.indentLine_indentLevel = 10

-- Conceal settings
vim.g.indentLine_setConceal = 1
vim.g.indentLine_concealcursor = "incv"
vim.g.indentLine_conceallevel = 2

-- vim.g.indentLine_char = "|"
vim.g.indentLine_char_list = {"|", "¦", "┆", "┊"}

-- Leading Space
vim.g.indentLine_leadingSpaceEnabled = 1
vim.g.indentLine_leadingSpaceChar = "•"

-- Use Theme Colors
-- vim.g.indentLine_setColors = 0

-- 16 Color
-- vim.g.indentLine_color_tty_light = 7 -- (default: 4)
-- vim.g.indentLine_color_dark = 1 -- (default: 2)

-- 256
-- vim.g.indentLine_color_term = 239

-- True Color
-- vim.g.indentLine_color_gui = "#616161"

-- Background (256, True)
-- vim.g.indentLine_bgcolor_term = 202
-- vim.g.indentLine_bgcolor_gui = "#FF5F00"
