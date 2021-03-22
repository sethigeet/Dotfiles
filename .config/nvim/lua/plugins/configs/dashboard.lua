vim.g.dashboard_default_executive = "telescope"

vim.g.dashboard_custom_section = {
    a = {description = {" Find File          "}, command = "Telescope find_files"},
    b = {description = {" Recently Used Files"}, command = "Telescope oldfiles"},
    c = {description = {" Load Last Session  "}, command = "SessionLoad"},
    d = {description = {" Find Word          "}, command = "Telescope live_grep"},
    e = {description = {" Marks              "}, command = "Telescope marks"},
    i = {description = {" Nvim Config        "}, command = "e ~/.config/nvim/init.lua"}
}

-- vim.g.file_browser = {description = {" File Browser"}, command = "Telescope find_files"},

-- vim.g.dashboard_custom_shortcut = {
--     a = "f",
--     find_word = "SPC f a",
--     last_session = "SPC s l",
--     new_file = "SPC c n",
--     book_marks = "SPC f b"
-- }
-- find_history = "SPC f h",

require("general.functions").define_augroups({
    dashboard = {
        {"FileType", "dashboard", "set showtabline=0"},
        {"WinLeave", "<buffer>", "set showtabline=2"}
    }
})

vim.g.dashboard_preview_command = "cat"
vim.g.dashboard_preview_pipeline = "lolcat"
vim.g.dashboard_preview_file = "~/.config/nvim/logo.txt"
vim.g.dashboard_preview_file_height = 12
vim.g.dashboard_preview_file_width = 80

vim.g.dashboard_session_directory = "~/.cache/nvim/session"
