vim.cmd("set iskeyword+=-") -- treat dash separated words as a word text object"
vim.cmd("set formatoptions-=cro") -- Stop newline continution of comments

vim.cmd("syntax enable") -- Enables syntax highlighing
vim.o.hidden = true -- Required to keep multiple buffers open multiple buffers
vim.wo.wrap = false -- Display long lines as just one line
vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.o.encoding = "utf-8" -- The encoding displayed
vim.o.pumheight = 10 -- Makes popup menu smaller
vim.o.fileencoding = "utf-8" -- The encoding written to file
vim.o.ruler = true -- Show the cursor position all the time
vim.o.cmdheight = 2 -- More space for displaying messages
vim.o.mouse = "a" -- Enable your mouse
vim.o.splitbelow = true -- Horizontal splits will automatically be below
vim.o.splitright = true -- Vertical splits will automatically be to the right
vim.o.t_Co = "256" -- Support 256 colors
vim.o.conceallevel = 0 -- So that I can see `` in markdown files
vim.o.tabstop = 2 -- Insert 2 spaces for a tab
vim.o.shiftwidth = 2 -- Change the number of space characters inserted for indentation
vim.o.smarttab = true -- Makes tabbing smarter will realize you have 2 vs 4
vim.o.expandtab = true -- Converts tabs to spaces
vim.o.smartindent = true -- Makes indenting smart
vim.o.autoindent = true -- Good auto indent
vim.o.laststatus = 2 -- Always display the status line
vim.wo.number = true -- Line numbers
vim.o.cursorline = true -- Enable highlighting of the current line
vim.o.background = "dark" -- tell vim what the background color looks like
vim.o.showtabline = 2 -- Always show tabs
-- vim.g.noshowmode = true -- We don't need to see things like -- INSERT -- anymore
vim.cmd("set noshowmode")
vim.cmd("set shortmess+=c") -- Don't pass messages to |ins-completion-menu|.
vim.wo.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
vim.o.updatetime = 300 -- Faster completion
vim.o.timeoutlen = 100 -- By default timeoutlen is 1000 ms
vim.o.clipboard = "unnamedplus" -- Copy paste between vim and everything else
vim.o.relativenumber = true
vim.o.incsearch = true
vim.cmd("set ts=2") -- Insert 2 spaces for a tab
vim.cmd("set sw=2") -- Change the number of space characters inserted for indentation
vim.cmd("set inccommand=split") -- Make substitution work in realtime
vim.o.title = true
-- vim.o.titlestring = "filename nvim"
vim.o.titlestring = "%F - nvim"

if vim.fn.has("persistent_undo") == 1 then
    vim.o.undodir = vim.fn.stdpath("data") .. "/undodir"
    vim.o.undofile = true
end

-- For Folding
-- Method for folding
vim.o.foldmethod = "indent"
-- Open all when entering for the first time
vim.o.foldlevel = 20

vim.cmd("au! BufWritePost $MYVIMRC luafile %") -- auto source when writing to init.lua alternatively you can run :source $MYVIMRC
