-- Options
vim.opt.hidden = true -- Required to keep multiple buffers open multiple buffers
vim.opt.scrolloff = Opts.scroll_off -- Minimal number of lines to keep above and below the cursor
vim.opt.wildignore = { "*.o", "*.a", "__pycache__", "*.pyc", "node_modules" }
vim.opt.encoding = "utf-8" -- The encoding displayed
vim.opt.pumheight = 10 -- Makes popup menu smaller
vim.opt.fileencoding = "utf-8" -- The encoding written to file
vim.opt.ruler = true -- Show the cursor position all the time
vim.opt.cmdheight = 2 -- More space for displaying messages
vim.opt.mouse = "a" -- Enable your mouse
vim.opt.splitbelow = true -- Horizontal splits will automatically be below
vim.opt.splitright = true -- Vertical splits will automatically be to the right
vim.opt.t_Co = "256" -- Support 256 colors
vim.opt.conceallevel = 0 -- So that I can see `` in markdown files
vim.opt.tabstop = 2 -- Insert 2 spaces for a tab
vim.opt.shiftwidth = 2 -- Change the number of space characters inserted for indentation
vim.opt.smarttab = true -- Makes tabbing smarter will realize you have 2 vs 4
vim.opt.expandtab = true -- Converts tabs to spaces
vim.opt.smartindent = true -- Makes indenting smart
vim.opt.autoindent = true -- Good auto indent
vim.opt.laststatus = 2 -- Always display the status line
vim.opt.cursorline = true -- Enable highlighting of the current line
vim.opt.background = "dark" -- tell vim what the background color looks like
vim.opt.showtabline = 2 -- Always show tabs
vim.opt.noshowmode = true
vim.opt_local.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
vim.opt.updatetime = 300 -- Faster completion
vim.opt.timeoutlen = 500 -- By default timeoutlen is 1000 ms
vim.opt.clipboard = "unnamedplus" -- Copy paste between vim and everything else
vim.opt.relativenumber = true
vim.opt.incsearch = true
vim.opt.ignorecase = true -- Ignore case while searching (required for smartcase)
vim.opt.smartcase = true -- Ignore case only when search does not include upper case character
vim.opt.inccommand = "split" -- Make substitution work in realtime
vim.opt.title = true
vim.opt.titlestring = "%F - nvim"
-- vim.opt.guifont = "FiraCode Nerd Font:15"
vim.opt.foldmethod = "manual" -- Set the method for folding
vim.opt.viminfo = "'20,<1000,s1000" -- Increase the max limit of the buffers so that we don't loose anything we yanked/deleted which is too large

vim.opt.iskeyword:append("-") -- treat dash separated words as a word text object"
vim.opt.whichwrap:append({ "<", ">", "[", "]", "h", "l" })
vim.opt.matchpairs:append("<:>")
vim.opt.shortmess:append("c") -- Don't pass messages to |ins-completion-menu|.

-- Local options
vim.opt_local.number = Opts.number -- Line numbers
vim.opt_local.relativenumber = Opts.relative_number -- Relative Line numbers
vim.opt_local.wrap = Opts.wrap_lines -- Display long lines as just one line

if vim.fn.has("persistent_undo") == 1 then
    vim.opt.undodir = DATA_PATH .. "/undodir"
    vim.opt.undofile = true
end

vim.cmd("syntax enable") -- Enables syntax highlighing
