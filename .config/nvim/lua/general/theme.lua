vim.cmd("set termguicolors")
vim.cmd("let ayucolor=\"mirage\"")
vim.cmd("colorscheme " .. Opts.colorscheme)

-- Syntax highlighting
vim.g.python_highlight_all = 1

-- Git diff colors
vim.cmd("highlight DiffAdd guifg=NONE guibg=#4D5E49")
vim.cmd("highlight DiffChange guifg=NONE guibg=#49545e")
vim.cmd("highlight DiffDelete guifg=NONE guibg=#5C4945")
