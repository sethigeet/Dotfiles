local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
  execute("packadd packer.nvim")
end

return require("packer").startup({
  function(use)
    -- Packer can manage itself as an optional plugin
    use("wbthomason/packer.nvim")

    -- TODO: Remove this once it this is merged (https://github.com/neovim/neovim/pull/13823)
    use("tjdevries/astronauta.nvim")

    -- Better Comments
    use({
      "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
      event = "BufRead",
      config = require("plugins.configs.todo_comments").setup,
      disable = not Opts.plugin.todo_comments.enabled,
    })
    use({
      "terrortylor/nvim-comment",
      event = "BufEnter",
      config = require("plugins.configs.comment").setup,
      disable = not Opts.plugin.comment.enabled,
    })

    -- Indent lines
    use({
      "lukas-reineke/indent-blankline.nvim",
      event = "ColorScheme",
      config = require("plugins.configs.indent_blankline").setup,
      disable = not Opts.plugin.indent_blankline.enabled,
    })

    -- Repeat stuff
    use("tpope/vim-repeat")

    -- Vifm
    use({
      "vifm/vifm.vim",
      config = require("plugins.configs.vifm").setup,
      disable = not Opts.plugin.vifm.enabled,
    })

    -- File Explorer
    use({
      "kyazdani42/nvim-tree.lua",
      cmd = {
        "NvimTreeClipboard",
        "NvimTreeClose",
        "NvimTreeFindFile",
        "NvimTreeOpen",
        "NvimTreeRefresh",
        "NvimTreeToggle",
      },
      config = function()
        require("plugins.configs.nvim_tree")
      end,
      requires = "kyazdani42/nvim-web-devicons", -- Cool Icons
    })

    -- Have the file system follow you around
    use({
      "ahmedkhalf/lsp-rooter.nvim",
      config = require("plugins.configs.rooter").setup,
      disable = not Opts.plugin.rooter.enabled,
    })

    -- Treesitter
    use({
      "nvim-treesitter/nvim-treesitter",
      config = require("plugins.configs.treesitter").setup,
      -- opt = true,
      disable = not Opts.plugin.treesitter.enabled,
    })
    -- Rename variables when lsp is not available and navigate through blocks of code
    use({
      "nvim-treesitter/nvim-treesitter-refactor",
      after = "nvim-treesitter",
      disable = not Opts.plugin.treesitter.enabled,
    })
    -- Move text objects intelligently
    use({
      "nvim-treesitter/nvim-treesitter-textobjects",
      after = "nvim-treesitter",
      disable = not Opts.plugin.treesitter.enabled,
    })
    -- Automatically close and rename tags
    use({
      "windwp/nvim-ts-autotag",
      after = "nvim-treesitter",
      disable = not Opts.plugin.treesitter.enabled,
    })
    -- Rainbow brackets
    use({
      "p00f/nvim-ts-rainbow",
      after = "nvim-treesitter",
      disable = not Opts.plugin.treesitter.enabled,
    })
    -- Change the comment string according to the location of the cursor in the file
    use({
      "JoosepAlviste/nvim-ts-context-commentstring",
      after = "nvim-treesitter",
      disable = not Opts.plugin.treesitter.enabled,
    })
    use({
      "andymass/vim-matchup", -- Extend vim's '%' functionality using `treesitter`
      event = "CursorMoved",
      config = require("plugins.configs.matchup").setup,
      after = "nvim-treesitter",
      disable = not Opts.plugin.matchup.enabled,
    })

    -- Auto pairs for "(", "[", "{", etc
    -- use({
    -- "windwp/nvim-autopairs",
    -- config = require("plugins.configs.autopairs").setup,
    -- after = "nvim-compe",
    -- event = "InsertEnter",
    -- disable = not Opts.plugin.autopairs.enabled,
    -- })
    use("jiangmiao/auto-pairs")

    -- Themes
    use("folke/tokyonight.nvim")
    -- use("ayu-theme/ayu-vim")

    -- Status Line
    use({
      "hoob3rt/lualine.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = require("plugins.configs.lualine").setup,
      disable = not Opts.plugin.lualine.enabled,
    })

    -- Git
    use("tpope/vim-fugitive")
    use({ "junegunn/gv.vim", requires = "tpope/vim-fugitive" })
    use({
      "rhysd/git-messenger.vim",
      event = "BufRead",
      config = require("plugins.configs.git_messenger").setup,
      disable = not Opts.plugin.git_messenger.enabled,
    })
    use({
      "lewis6991/gitsigns.nvim",
      requires = "nvim-lua/plenary.nvim",
      event = "BufRead",
      config = require("plugins.configs.gitsigns").setup,
      disable = not Opts.plugin.gitsigns.enabled,
    })
    use({
      "f-person/git-blame.nvim",
      event = "BufRead",
      config = require("plugins.configs.git_blame").setup,
      disable = not Opts.plugin.git_blame.enabled,
    })
    -- use {
    -- "TimUntersberger/neogit",
    -- requires = "nvim-lua/plenary.nvim",
    -- config = require("plugins.configs.neogit").setup,
    -- disable = not Opts.plugin.neogit.enabled,
    -- }

    -- Terminal
    use({
      "numtostr/FTerm.nvim",
      keys = { "<F1>", "<leader>T" },
      module = { "FTerm", "FTerm.terminal" },
      config = require("plugins.configs.fterm").setup,
      disable = not Opts.plugin.fterm.enabled,
    })

    -- Start Screen
    use({
      "glepnir/dashboard-nvim",
      config = require("plugins.configs.dashboard").setup,
      disable = not Opts.plugin.dashboard.enabled,
    })
    -- use {"mhinz/vim-startify", config = require("plugins.configs.startify").setup end}

    -- See what keys do like in emacs
    use({
      "folke/which-key.nvim",
      config = function()
        require("plugins.configs.which_key")
      end,
    })

    -- Snippets
    use({
      "hrsh7th/vim-vsnip",
      requires = "hrsh7th/vim-vsnip-integ",
      event = "InsertEnter",
      config = require("plugins.configs.vsnip").setup,
      disable = not Opts.plugin.vsnip.enabled,
    })
    use({ "rafamadriz/friendly-snippets", event = "InsertEnter" })

    -- Interactive code
    use({
      "metakirby5/codi.vim",
      cmd = "Codi",
      config = require("plugins.configs.codi").setup,
      disable = not Opts.plugin.codi.enabled,
    })

    -- Better tabline
    use({
      "akinsho/nvim-bufferline.lua",
      requires = "kyazdani42/nvim-web-devicons",
      config = require("plugins.configs.bufferline").setup,
      disable = not Opts.plugin.bufferline.enabled,
    })

    -- Better quickfix menu
    use({
      "kevinhwang91/nvim-bqf",
      config = require("plugins.configs.bqf").setup,
      disable = not Opts.plugin.bqf.enabled,
    })
    use({
      "folke/lsp-trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      cmd = { "Trouble", "TroubleToggle", "Telescope" },
      module = "telescope",
      config = require("plugins.configs.trouble").setup,
      disable = not Opts.plugin.trouble.enabled,
    })

    -- Intuitive buffer closing
    use({ "famiu/bufdelete.nvim", cmd = "Bdelete" })

    -- Undo time travel
    use({ "mbbill/undotree", cmd = { "UndotreeShow", "UndotreeToggle" } })

    -- Smooth scroll
    use({ "psliwka/vim-smoothie", event = "BufEnter" })

    -- Colorizer
    use({
      "norcalli/nvim-colorizer.lua",
      event = "BufRead",
      config = require("plugins.configs.colorizer").setup,
      disable = not Opts.plugin.colorizer.enabled,
    })

    -- Multiple Cursors
    use({ "terryma/vim-multiple-cursors", keys = { "<C-n>" }, event = "BufRead" })

    -- Telescope
    use({
      "nvim-telescope/telescope.nvim",
      requires = {
        "nvim-lua/plenary.nvim",
        "nvim-lua/popup.nvim",
        "nvim-telescope/telescope-media-files.nvim",
        "nvim-telescope/telescope-fzy-native.nvim",
        "nvim-telescope/telescope-project.nvim",
      },
      config = function()
        require("plugins.configs.telescope")
      end,
      after = "lsp-trouble.nvim",
      -- disable = not Opts.plugin.telescope.enabled,
    })

    -- Intellisense
    use("neovim/nvim-lspconfig")
    use("kabouzeid/nvim-lspinstall")
    use({
      "hrsh7th/nvim-compe",
      config = require("plugins.configs.compe").setup,
      after = "nvim-lspconfig",
      event = "InsertEnter",
      disable = not Opts.plugin.compe.enabled,
    })
    use({
      "glepnir/lspsaga.nvim",
      event = "BufRead",
      config = require("plugins.configs.lspsaga").setup,
      after = "nvim-lspconfig",
      disable = not Opts.plugin.lspsaga.enabled,
    })
    use({ "folke/lsp-colors.nvim", event = "BufRead" })
    use({ "RishabhRD/nvim-lsputils", requires = { "RishabhRD/popfix" } })
    use({
      "simrat39/symbols-outline.nvim",
      cmd = {
        "SymbolsOutline",
        "SymbolsOutlineOpen",
        "SymbolsOutlineClose",
      },
      config = require("plugins.configs.symbols_outline").setup,
      disable = not Opts.plugin.symbols_outline.enabled,
    })
    use({
      "ray-x/lsp_signature.nvim",
      event = "InsertEnter",
      config = require("plugins.configs.lsp_signature").setup,
      disable = not Opts.plugin.lsp_signature.enabled,
    })
    -- Language specific plugins
    use({
      "fatih/vim-go",
      ft = { "go" },
      run = function()
        vim.cmd("GoUpdateBinaries")
      end,
    })

    -- Markdown preview
    use({
      "iamcco/markdown-preview.nvim",
      ft = { "markdown", "markdownreact" },
      run = "cd app && npm install",
      config = require("plugins.configs.markdown_preview").setup,
      disable = not Opts.plugin.markdown_preview.enabled,
    })

    -- Easily change surrounding elements
    use({ "tpope/vim-surround", event = "BufRead" })

    -- Extend increment/decrement functionality
    use({
      "monaqa/dial.nvim",
      event = "BufRead",
      config = require("plugins.configs.dial").setup,
      disable = not Opts.plugin.dial.enabled,
    })

    -- Interact with databases
    use({ "tpope/vim-dadbod", disable = not Opts.plugin.dadbod.enabled, cmd = "DB" })
    use({
      "kristijanhusak/vim-dadbod-ui",
      config = require("plugins.configs.dadbod").setup,
      disable = not Opts.plugin.dadbod.enabled,
      cmd = { "DBUI", "DBUIToggle" },
      after = "vim-dadbod",
    })
    use({ "kristijanhusak/vim-dadbod-completion", after = "vim-dadbod-ui" })

    -- Jump to lines more interactively
    use({
      "nacro90/numb.nvim",
      event = "BufRead",
      config = require("plugins.configs.numb").setup,
      disable = not Opts.plugin.numb.enabled,
    })

    -- Distraction free writing (zen mode)
    use({
      "folke/zen-mode.nvim",
      cmd = "ZenMode",
      config = require("plugins.configs.zen_mode").setup,
      disable = not Opts.plugin.zen_mode.enabled,
    })

    -- The emmet plugin for vim
    use({
      "mattn/emmet-vim",
      event = "InsertEnter",
      config = require("plugins.configs.emmet").setup,
      disable = not Opts.plugin.emmet.enabled,
    })

    -- Run selected blocks of code
    use({
      "michaelb/sniprun",
      run = "bash ./install.sh",
      config = require("plugins.configs.sniprun").setup,
      disable = not Opts.plugin.sniprun.enabled,
    })

    -- Quickly align text by pattern
    use({
      "godlygeek/tabular",
      cmd = "Tabularize",
      config = require("plugins.configs.tabular").setup,
      disable = not Opts.plugin.tabular.enabled,
    })

    -- Search and replace text interactively
    use({
      "windwp/nvim-spectre",
      requires = { "nvim-lua/plenary.nvim", "nvim-lua/popup.nvim" },
      event = "BufRead",
      config = require("plugins.configs.spectre").setup,
      disable = not Opts.plugin.spectre.enabled,
    })

    -- REST client in nvim
    use({
      "NTBBloodbath/rest.nvim",
      requires = { "nvim-lua/plenary.nvim" },
      config = function()
        require("rest-nvim").setup()
      end,
      event = "BufEnter",
    })
  end,

  config = {
    git = { clone_timeout = 300 },
    display = {
      open_fn = function()
        return require("packer.util").float({ border = "rounded" })
      end,
    },
    profile = {
      enable = true,
      threshold = 1, -- the amount in ms that a plugins load time must be over for it to be included in the profile
    },
  },
})
