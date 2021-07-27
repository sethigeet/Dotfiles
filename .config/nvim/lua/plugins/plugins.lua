local plugins = {
  -- Packer can manage itself as an optional plugin
  {
    "wbthomason/packer.nvim",
    opt = true,
  },

  -- Better Comments
  {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    event = "BufRead",
    config = "todo_comments",
  },
  {
    "b3nj5m1n/kommentary",
    event = "BufEnter",
    config = "kommentary",
  },

  -- Indent lines
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufEnter",
    config = "indent_blankline",
  },

  -- Repeat stuff
  "tpope/vim-repeat",

  -- Vifm
  {
    "vifm/vifm.vim",
    config = "vifm",
  },

  -- File Explorer
  {
    "kyazdani42/nvim-tree.lua",
    cmd = {
      "NvimTreeClipboard",
      "NvimTreeClose",
      "NvimTreeFindFile",
      "NvimTreeOpen",
      "NvimTreeRefresh",
      "NvimTreeToggle",
    },
    config = "nvim_tree",
    requires = "kyazdani42/nvim-web-devicons", -- Cool Icons
  },

  -- Have the file system follow you around
  -- TODO: Replace with the newer version once that is complete
  {
    "airblade/vim-rooter",
    -- "ahmedkhalf/lsp-rooter.nvim",
    -- config = "rooter",
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    config = "treesitter",
  },
  -- Playground to interact with treesitter nodes
  {
    "nvim-treesitter/playground",
    after = "nvim-treesitter",
  },
  -- Rename variables when lsp is not available and navigate through blocks of code
  {
    "nvim-treesitter/nvim-treesitter-refactor",
    after = "nvim-treesitter",
  },
  -- Move text objects intelligently
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    after = "nvim-treesitter",
  },
  -- Automatically close and rename tags
  {
    "windwp/nvim-ts-autotag",
    after = "nvim-treesitter",
  },
  -- Rainbow brackets
  {
    "p00f/nvim-ts-rainbow",
    after = "nvim-treesitter",
  },
  -- Change the comment string according to the location of the cursor in the file
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    after = "nvim-treesitter",
  },
  {
    "andymass/vim-matchup", -- Extend vim's '%' functionality using `treesitter`
    event = "CursorMoved",
    config = "matchup",
    after = "nvim-treesitter",
  },

  -- Auto pairs for "(", "[", "{", etc
  -- {
  -- "windwp/nvim-autopairs",
  -- config = "autopairs",
  -- after = "nvim-compe",
  -- event = "InsertEnter",
  -- },
  "jiangmiao/auto-pairs",

  -- Themes
  "folke/tokyonight.nvim",
  -- "ayu-theme/ayu-vim"

  -- Status Line
  {
    "hoob3rt/lualine.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = "lualine",
  },

  -- Git
  "tpope/vim-fugitive",
  { "junegunn/gv.vim", requires = "tpope/vim-fugitive" },
  {
    "rhysd/git-messenger.vim",
    event = "BufRead",
    config = "git_messenger",
  },
  {
    "lewis6991/gitsigns.nvim",
    requires = "nvim-lua/plenary.nvim",
    event = "BufRead",
    config = "gitsigns",
  },
  {
    "f-person/git-blame.nvim",
    event = "BufRead",
    config = "git_blame",
  },
  -- use {
  -- "TimUntersberger/neogit",
  -- requires = "nvim-lua/plenary.nvim",
  -- config = "neogit",
  -- }

  -- Terminal
  {
    "akinsho/nvim-toggleterm.lua",
    keys = { "`", "<F1>", "<leader>T" },
    module = { "toggleterm", "toggleterm.terminal" },
    config = "toggleterm",
  },

  -- Start Screen
  {
    "glepnir/dashboard-nvim",
    config = "dashboard",
  },
  -- use { "mhinz/vim-startify", config = "startify" }

  -- See what keys do like in emacs
  {
    "folke/which-key.nvim",
    config = "which_key",
  },

  -- Snippets
  {
    "hrsh7th/vim-vsnip",
    requires = "hrsh7th/vim-vsnip-integ",
    event = "InsertEnter",
    config = "vsnip",
  },
  { "rafamadriz/friendly-snippets", event = "InsertEnter" },

  -- Interactive code
  {
    "metakirby5/codi.vim",
    cmd = "Codi",
    config = "codi",
  },

  -- Better tabline
  {
    "akinsho/nvim-bufferline.lua",
    requires = "kyazdani42/nvim-web-devicons",
    config = "bufferline",
  },

  -- Better quickfix menu
  {
    "kevinhwang91/nvim-bqf",
    config = "bqf",
  },
  {
    "folke/lsp-trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    cmd = { "Trouble", "TroubleToggle" },
    keys = { "<C-q>" },
    module = "trouble",
    config = "trouble",
  },

  -- Intuitive buffer closing
  { "famiu/bufdelete.nvim", cmd = "Bdelete" },

  -- Undo time travel
  { "mbbill/undotree", cmd = { "UndotreeShow", "UndotreeToggle" } },

  -- Smooth scroll
  {
    "karb94/neoscroll.nvim",
    event = "BufEnter",
    config = "neoscroll",
  },

  -- Colorizer
  {
    "norcalli/nvim-colorizer.lua",
    event = "BufRead",
    config = "colorizer",
  },

  -- Multiple Cursors
  { "terryma/vim-multiple-cursors", keys = { "<C-n>", "g<M-n>" }, event = "BufRead" },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-lua/popup.nvim",
      "nvim-telescope/telescope-media-files.nvim",
      "nvim-telescope/telescope-fzy-native.nvim",
      "nvim-telescope/telescope-project.nvim",
      "nvim-telescope/telescope-symbols.nvim",
      "nvim-telescope/telescope-fzf-writer.nvim",
      { "nvim-telescope/telescope-frecency.nvim", requires = "tami5/sql.nvim" },
    },
    cmd = "Telescope",
    config = "telescope",
    after = "lsp-trouble.nvim",
  },

  -- Intellisense
  "neovim/nvim-lspconfig",
  "kabouzeid/nvim-lspinstall",
  {
    "jose-elias-alvarez/null-ls.nvim",
    requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  },
  {
    "hrsh7th/nvim-compe",
    config = "compe",
    after = "nvim-lspconfig",
    event = "InsertEnter",
  },
  {
    "simrat39/symbols-outline.nvim",
    cmd = {
      "SymbolsOutline",
      "SymbolsOutlineOpen",
      "SymbolsOutlineClose",
    },
    config = "symbols_outline",
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "InsertEnter",
    config = "lsp_signature",
  },
  -- Language specific plugins
  {
    "fatih/vim-go",
    ft = { "go" },
    run = 'vim.cmd("GoUpdateBinaries")',
  },

  -- Markdown preview
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown", "markdownreact" },
    run = "cd app && npm install",
    config = "markdown_preview",
  },

  -- Easily change surrounding elements
  {
    "tpope/vim-surround",
    event = "BufRead",
  },

  -- Extend increment/decrement functionality
  {
    "monaqa/dial.nvim",
    event = "BufRead",
    config = "dial",
  },

  -- Interact with databases
  { "tpope/vim-dadbod", cmd = "DB" },
  {
    "kristijanhusak/vim-dadbod-ui",
    config = "dadbod",
    cmd = { "DBUI", "DBUIToggle" },
    after = "vim-dadbod",
  },
  { "kristijanhusak/vim-dadbod-completion", after = "vim-dadbod-ui" },

  -- Jump to lines more interactively
  {
    "nacro90/numb.nvim",
    event = "BufRead",
    config = "numb",
  },

  -- Distraction free writing (zen mode)
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    config = "zen_mode",
  },

  -- The emmet plugin for vim
  {
    "mattn/emmet-vim",
    event = "InsertEnter",
    config = "emmet",
  },

  -- Run selected blocks of code
  {
    "michaelb/sniprun",
    run = "bash ./install.sh",
    config = "sniprun",
  },

  -- Quickly align text by pattern
  {
    "godlygeek/tabular",
    cmd = "Tabularize",
    config = "tabular",
  },

  -- Search and replace text interactively
  {
    "windwp/nvim-spectre",
    requires = { "nvim-lua/plenary.nvim", "nvim-lua/popup.nvim" },
    event = "BufRead",
    config = "spectre",
  },

  -- REST client in nvim
  {
    "NTBBloodbath/rest.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("rest-nvim").setup()
    end,
    event = "BufEnter",
  },
}

local config = {
  git = { clone_timeout = 300 },
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
  profile = {
    enable = true,
    threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
  },
}

return {
  plugins = plugins,
  config = config,
}
