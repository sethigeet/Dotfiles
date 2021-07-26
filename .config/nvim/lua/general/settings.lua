-- Options
vim.opt.hidden = true -- Required to keep multiple buffers open multiple buffers
vim.opt.scrolloff = 4 -- Minimal number of lines to keep above and below the cursor
vim.opt.sidescrolloff = 4 -- Minimal number of lines to keep on the right and the left side of the cursor
vim.opt.encoding = "utf-8" -- The encoding displayed
vim.opt.pumheight = 10 -- Makes popup menu smaller
vim.opt.fileencoding = "utf-8" -- The encoding written to file
vim.opt.ruler = true -- Show the cursor position all the time
vim.opt.cmdheight = 2 -- More space for displaying messages
vim.opt.mouse = "a" -- Enable the mouse
vim.opt.splitbelow = true -- Horizontal splits will automatically be below
vim.opt.splitright = true -- Vertical splits will automatically be to the right
vim.opt.conceallevel = 0 -- So that I can see `` in markdown files
vim.opt.tabstop = 2 -- The tab width
vim.opt.shiftwidth = 2 -- Change the number of space characters inserted for indentation
vim.opt.smarttab = true -- Makes tabbing smarter will realize you have 2 vs 4
vim.opt.expandtab = true -- Converts tabs to spaces
vim.opt.smartindent = true -- Makes indenting smart
vim.opt.autoindent = true -- Good auto indent
vim.opt.copyindent = true
vim.opt.preserveindent = true
vim.opt.laststatus = 2 -- Always display the status line
vim.opt.cursorline = true -- Enable highlighting of the current line
vim.opt.background = "dark" -- tell vim what the background color looks like
vim.opt.showtabline = 2 -- Always show tabs
vim.opt.updatetime = 300 -- Faster completion
vim.opt.timeoutlen = 250 -- By default timeoutlen is 1000 ms
vim.opt.clipboard = "unnamedplus" -- Copy paste between vim and everything else
vim.opt.incsearch = true -- Show the results while searching before pressing return
vim.opt.ignorecase = true -- Ignore case while searching (required for smartcase)
vim.opt.smartcase = true -- Ignore case only when search does not include upper case character
vim.opt.inccommand = "split" -- Make substitution work in realtime
vim.opt.title = true
vim.opt.titlestring = "%F - nvim"
vim.opt.guifont = "monospace:h18"
vim.opt.foldmethod = "manual" -- Set the method for folding
vim.opt.viminfo = "'20,<1000,s1000" -- Increase the max limit of the buffers so that we don't loose anything we yanked/deleted which is too large
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.grepprg = "rg --vimgrep" -- Change `vimgrep` to use `rg`
vim.opt.grepformat = "%f:%l:%c:%m"

vim.opt.iskeyword:append("-") -- treat dash separated words as a word text object
vim.opt.matchpairs:append("<:>")
vim.opt.shortmess:append("astc")
vim.opt.formatoptions:remove({ "c", "r", "o" })
vim.opt.wildignore:append({ "*.o", "*.a", "__pycache__", "*.pyc", "node_modules" })

-- Local options
vim.opt_local.number = true -- Line numbers
vim.opt_local.relativenumber = true -- Relative Line numbers
vim.opt_local.wrap = false -- Display long lines as just one line
vim.opt_local.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time

-- Legacy stuff
vim.cmd("set t_Co=256") -- Support 256 colors
vim.cmd("set noshowmode")
-- TODO: Figure out why does this not work with `vim.opt`
vim.cmd("set whichwrap+=<,>,[,],h,l")

if vim.fn.has("persistent_undo") == 1 then
  vim.opt.undodir = DATA_PATH .. "/undodir"
  vim.opt.undofile = true
end

vim.cmd("syntax enable") -- Enables syntax highlighing
