vim.g.tokyonight_style = "night"
vim.cmd("colorscheme tokyonight")

-- Git diff colors
vim.cmd([[
  hi DiffAdd        guibg=#283B4D guifg=NONE
  hi DiffChange     guibg=#283B4D guifg=NONE
  hi DiffDelete     guibg=#3C2C3C guifg=#725272 gui=bold
  hi DiffText       guibg=#365069 guifg=NONE
  hi SelectNextKey                guifg=#FF007C gui=bold
]])
