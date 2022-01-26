local opt = vim.opt

-- Options
local opts = {
  backup = false, -- Do not create a backup file
  backupcopy = "yes", -- While saving a file, make a copy of it and then write the new contents to the original file
  hidden = true, -- Required to keep multiple buffers open multiple buffers
  scrolloff = 4, -- Minimal number of lines to keep above and below the cursor
  sidescrolloff = 4, -- Minimal number of lines to keep on the right and the left side of the cursor
  pumheight = 10, -- Makes popup menu smaller
  encoding = "utf-8", -- The encoding displayed
  fileencoding = "utf-8", -- The encoding written to file
  ruler = true, -- Show the cursor position all the time
  mouse = "a", -- Enable the mouse
  splitbelow = true, -- Horizontal splits will automatically be below
  splitright = true, -- Vertical splits will automatically be to the right
  conceallevel = 0, -- So that I can see `` in markdown files
  showmode = false, -- we don't need to see things like -- INSERT -- anymore
  tabstop = 2, -- The tab width
  shiftwidth = 2, -- Change the number of space characters inserted for indentation
  smarttab = true, -- Makes tabbing smarter will realize you have 2 vs 4
  expandtab = true, -- Converts tabs to spaces
  smartindent = true, -- Makes indenting smart
  autoindent = true, -- Good auto indent
  copyindent = true,
  preserveindent = true,
  laststatus = 2, -- Always display the status line
  cursorline = true, -- Enable highlighting of the current line
  background = "dark", -- tell vim what the background color looks like
  showtabline = 2, -- Always show tabs
  updatetime = 300, -- Faster completion
  termguicolors = true, -- set term gui colors (most terminals support this)
  timeoutlen = 250, -- By default timeoutlen is 1000 ms
  clipboard = "unnamedplus", -- Copy paste between vim and everything else
  incsearch = true, -- Show the results while searching before pressing return
  ignorecase = true, -- Ignore case while searching (required for smartcase)
  smartcase = true, -- Ignore case only when search does not include upper case character
  inccommand = "split", -- Make substitution work in realtime
  title = true,
  titlestring = "%F - nvim",
  guifont = "monospace:h18",
  foldmethod = "manual", -- Set the method for folding
  foldexpr = "", -- Set the method for folding
  viminfo = "'20,<1000,s1000", -- Increase the max limit of the buffers so that we don't loose anything we yanked/deleted which is too large
  completeopt = { "menuone", "preview", "noselect" },
  grepprg = "rg --vimgrep", -- Change `vimgrep` to use `rg`
  grepformat = "%f:%l:%c:%m",
  number = true, -- Line numbers
  relativenumber = true, -- Relative Line numbers
  wrap = false, -- Display long lines as just one line
  signcolumn = "yes", -- Always show the signcolumn, otherwise it would shift the text each time
}
for k, v in pairs(opts) do
  opt[k] = v
end

opt.iskeyword:append("-") -- treat dash separated words as a word text object
opt.matchpairs:append("<:>")
opt.shortmess:append("astc")
opt.formatoptions:remove({ "c", "r", "o" })
opt.wildignore:append({ "*.o", "*.a", "__pycache__", "*.pyc", "node_modules" })

-- Legacy stuff
vim.cmd("set t_Co=256") -- Support 256 colors
-- TODO: Figure out why does this not work with `vim.opt`
vim.cmd("set whichwrap+=<,>,[,],h,l")

if vim.fn.has("persistent_undo") == 1 then
  opt.undodir = DATA_PATH .. "/undodir"
  opt.undofile = true
end

vim.cmd("syntax enable") -- Enables syntax highlighing
