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

    -- Better Comments
    use({
      "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
      event = "BufRead",
      config = function()
        require("plugins.configs.todo_comments").setup()
      end,
      disable = not Opts.plugin.todo_comments.enabled,
    })
    use("suy/vim-context-commentstring") -- Useful for React Commenting
    use({
      "terrortylor/nvim-comment",
      event = "BufRead",
      config = function()
        require("plugins.configs.comment").setup()
      end,
      disable = not Opts.plugin.comment.enabled,
    })

    -- Indent lines
    use({
      "lukas-reineke/indent-blankline.nvim",
      event = "BufRead",
      config = function()
        require("plugins.configs.indent_blankline").setup()
      end,
      disable = not Opts.plugin.indent_blankline.enabled,
    })

    -- Repeat stuff
    use("tpope/vim-repeat")

    -- Vifm
    use({
      "vifm/vifm.vim",
      config = function()
        require("plugins.configs.vifm").setup()
      end,
      disable = not Opts.plugin.vifm.enabled,
    })

    -- File Explorer
    use({
      "kyazdani42/nvim-tree.lua",
      config = function()
        require("plugins.configs.nvim_tree")
      end,
      requires = "kyazdani42/nvim-web-devicons", -- Cool Icons
    })

    -- Easymotion
    use({
      "easymotion/vim-easymotion",
      event = "BufRead",
      config = function()
        require("plugins.configs.easymotion").setup()
      end,
      disable = not Opts.plugin.easymotion.enabled,
    })

    -- Have the file system follow you around
    use({
      "ahmedkhalf/lsp-rooter.nvim",
      config = function()
        require("plugins.configs.rooter").setup()
      end,
      disable = not Opts.plugin.rooter.enabled,
    })

    -- auto set indent settings
    use("tpope/vim-sleuth")

    -- Treesitter
    use({
      "nvim-treesitter/nvim-treesitter",
      config = function()
        require("plugins.configs.treesitter").setup()
      end,
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
      config = function()
        require("plugins.configs.matchup").setup()
      end,
      after = "nvim-treesitter",
      disable = not Opts.plugin.matchup.enabled,
    })

    -- Auto pairs for "(", "[", "{", etc
    -- use({
    -- "windwp/nvim-autopairs",
    -- config = function()
    -- require("plugins.configs.autopairs").setup()
    -- end,
    -- after = "nvim-compe",
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
      config = function()
        require("plugins.configs.lualine").setup()
      end,
      disable = not Opts.plugin.lualine.enabled,
    })

    -- Git
    use("tpope/vim-fugitive")
    use({ "junegunn/gv.vim", requires = "tpope/vim-fugitive" })
    use({
      "rhysd/git-messenger.vim",
      event = "BufRead",
      config = function()
        require("plugins.configs.git_messenger").setup()
      end,
      disable = not Opts.plugin.git_messenger.enabled,
    })
    use({
      "lewis6991/gitsigns.nvim",
      requires = "nvim-lua/plenary.nvim",
      event = "BufRead",
      config = function()
        require("plugins.configs.gitsigns").setup()
      end,
      disable = not Opts.plugin.gitsigns.enabled,
    })
    use({
      "f-person/git-blame.nvim",
      event = "BufRead",
      config = function()
        require("plugins.configs.git_blame").setup()
      end,
      disable = not Opts.plugin.git_blame.enabled,
    })
    -- use {
    -- "TimUntersberger/neogit",
    -- requires = "nvim-lua/plenary.nvim",
    -- config = function()
    -- require("plugins.configs.neogit").setup()
    -- end,
    -- disable = not Opts.plugin.neogit.enabled,
    -- }

    -- Terminal
    use({
      "numtostr/FTerm.nvim",
      event = "BufRead",
      config = function()
        require("plugins.configs.fterm").setup()
      end,
      disable = not Opts.plugin.fterm.enabled,
    })

    -- Start Screen
    use({
      "glepnir/dashboard-nvim",
      config = function()
        require("plugins.configs.dashboard").setup()
      end,
      disable = not Opts.plugin.dashboard.enabled,
    })
    -- use {"mhinz/vim-startify", config = function() require("plugins.configs.startify").setup() end}

    -- See what keys do like in emacs
    use({
      "folke/which-key.nvim",
      config = function()
        require("plugins.configs.whichkey")
      end,
    })

    -- Snippets
    use({
      "hrsh7th/vim-vsnip",
      requires = "hrsh7th/vim-vsnip-integ",
      event = "InsertEnter",
      config = function()
        require("plugins.configs.vsnip").setup()
      end,
      disable = not Opts.plugin.vsnip.enabled,
    })
    use({ "rafamadriz/friendly-snippets", event = "InsertEnter" })

    -- Interactive code
    use({
      "metakirby5/codi.vim",
      cmd = "Codi",
      config = function()
        require("plugins.configs.codi").setup()
      end,
      disable = not Opts.plugin.codi.enabled,
    })

    -- Better tabline
    use({
      "akinsho/nvim-bufferline.lua",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("plugins.configs.bufferline").setup()
      end,
      disable = not Opts.plugin.bufferline.enabled,
    })

    -- Better quickfix menu
    use({
      "kevinhwang91/nvim-bqf",
      config = function()
        require("plugins.configs.bqf").setup()
      end,
      disable = not Opts.plugin.bqf.enabled,
    })
    use({
      "folke/lsp-trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      cmd = { "Trouble", "TroubleToggle", "Telescope" },
      config = function()
        require("plugins.configs.trouble").setup()
      end,
      disable = not Opts.plugin.trouble.enabled,
    })

    -- Intuitive buffer closing
    use({ "famiu/bufdelete.nvim", event = "BufEnter" })

    -- Undo time travel
    use({ "mbbill/undotree", event = "BufEnter" })

    -- Smooth scroll
    use({ "psliwka/vim-smoothie", event = "BufEnter" })

    -- Colorizer
    use({
      "norcalli/nvim-colorizer.lua",
      event = "BufRead",
      config = function()
        require("plugins.configs.colorizer").setup()
      end,
      disable = not Opts.plugin.colorizer.enabled,
    })

    -- Multiple Cursors
    use({ "terryma/vim-multiple-cursors", event = "BufRead" })

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
    use({ "neovim/nvim-lspconfig" })
    use({ "kabouzeid/nvim-lspinstall" })
    use({
      "hrsh7th/nvim-compe",
      config = function()
        require("plugins.configs.compe").setup()
      end,
      event = "InsertEnter",
      disable = not Opts.plugin.compe.enabled,
    })
    use({
      "glepnir/lspsaga.nvim",
      config = function()
        require("plugins.configs.lspsaga").setup()
      end,
      event = "BufRead",
      disable = not Opts.plugin.lspsaga.enabled,
    })
    use({ "RishabhRD/nvim-lsputils", requires = { "RishabhRD/popfix" } })
    use({
      "simrat39/symbols-outline.nvim",
      cmd = "SymbolsOutline",
      config = function()
        require("plugins.configs.symbols_outline").setup()
      end,
      disable = not Opts.plugin.symbols_outline.enabled,
    })
    use({
      "fatih/vim-go",
      ft = { "go" },
      run = function()
        vim.cmd("GoUpdateBinaries")
      end,
    })
    use({
      "ray-x/lsp_signature.nvim",
      event = "InsertEnter",
      config = function()
        require("plugins.configs.lsp_signature").setup()
      end,
      disable = not Opts.plugin.lsp_signature.enabled,
    })
    use({ "folke/lsp-colors.nvim", event = "BufRead" })

    -- Markdown preview
    use({
      "iamcco/markdown-preview.nvim",
      ft = { "markdown", "markdownreact" },
      run = "cd app && npm install",
      config = function()
        require("plugins.configs.markdown_preview").setup()
      end,
      disable = not Opts.plugin.markdown_preview.enabled,
    })

    -- Easily change surrounding elements
    use({ "tpope/vim-surround", event = "BufRead" })

    -- Extend increment/decrement functionality
    use({
      "monaqa/dial.nvim",
      event = "BufRead",
      config = function()
        require("plugins.configs.dial").setup()
      end,
      disable = not Opts.plugin.dial.enabled,
    })

    -- Better bookmarks
    use({
      "MattesGroeger/vim-bookmarks",
      config = function()
        require("plugins.configs.bookmarks").setup()
      end,
      disable = not Opts.plugin.bookmarks.enabled,
    })

    -- Interact with databases
    use({ "tpope/vim-dadbod", disable = not Opts.plugin.dadbod.enabled })
    use({
      "kristijanhusak/vim-dadbod-ui",
      config = function()
        require("plugins.configs.dadbod").setup()
      end,
      disable = not Opts.plugin.dadbod.enabled,
    })
    use("kristijanhusak/vim-dadbod-completion")

    -- Jump to lines more interactively
    use({
      "nacro90/numb.nvim",
      event = "BufRead",
      config = function()
        require("plugins.configs.numb").setup()
      end,
      disable = not Opts.plugin.numb.enabled,
    })

    -- Distraction free writing (zen mode)
    use({
      "folke/zen-mode.nvim",
      cmd = "ZenMode",
      config = function()
        require("plugins.configs.zen_mode").setup()
      end,
      disable = not Opts.plugin.zen_mode.enabled,
    })

    -- The emmet plugin for vim
    use({
      "mattn/emmet-vim",
      event = "InsertEnter",
      config = function()
        require("plugins.configs.emmet").setup()
      end,
      disable = not Opts.plugin.emmet.enabled,
    })

    -- Run selected blocks of code
    use({
      "michaelb/sniprun",
      run = "bash ./install.sh",
      config = function()
        require("plugins.configs.sniprun").setup()
      end,
      disable = not Opts.plugin.sniprun.enabled,
    })

    -- Quickly align text by pattern
    use({
      "godlygeek/tabular",
      cmd = "Tabularize",
      config = function()
        require("plugins.configs.tabular").setup()
      end,
      disable = not Opts.plugin.tabular.enabled,
    })

    -- Search and replace text interactively
    use({
      "windwp/nvim-spectre",
      requires = { "nvim-lua/plenary.nvim", "nvim-lua/popup.nvim" },
      event = "BufRead",
      config = function()
        require("plugins.configs.spectre").setup()
      end,
      disable = not Opts.plugin.spectre.enabled,
    })

    -- REST client in nvim
    use({
      "NTBBloodbath/rest.nvim",
      requires = { "nvim-lua/plenary.nvim" },
      config = function()
        require("rest-nvim").setup()
      end,
    })
  end,

  config = {
    git = { clone_timeout = 300 },
    display = {
      open_fn = function()
        return require("packer.util").float({ border = "single" })
      end,
    },
    profile = {
      enable = true,
      threshold = 1, -- the amount in ms that a plugins load time must be over for it to be included in the profile
    },
  },
})
