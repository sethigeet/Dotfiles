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
        require("plugins.configs.todo-comments")
      end,
    })
    use("suy/vim-context-commentstring") -- Useful for React Commenting
    use({
      "terrortylor/nvim-comment",
      event = "BufRead",
      config = function()
        require("plugins.configs.comment")
      end,
    })

    -- Indent lines
    use({
      "lukas-reineke/indent-blankline.nvim",
      event = "BufRead",
      config = function()
        require("plugins.configs.indent-blankline")
      end,
    })

    -- Repeat stuff
    use("tpope/vim-repeat")

    -- Vifm
    use({
      "vifm/vifm.vim",
      config = function()
        require("plugins.configs.vifm")
      end,
    })

    -- File Explorer
    use({
      "kyazdani42/nvim-tree.lua",
      config = function()
        require("plugins.configs.nvim-tree")
      end,
      requires = "kyazdani42/nvim-web-devicons", -- Cool Icons
    })

    -- Easymotion
    use({
      "easymotion/vim-easymotion",
      event = "BufRead",
      config = function()
        require("plugins.configs.easymotion")
      end,
    })

    -- Have the file system follow you around
    use({
      "ahmedkhalf/lsp-rooter.nvim",
      config = function()
        require("plugins.configs.rooter")
      end,
    })

    -- auto set indent settings
    use("tpope/vim-sleuth")

    -- Treesitter
    use({
      "nvim-treesitter/nvim-treesitter",
      config = function()
        require("plugins.configs.treesitter")
      end,
      -- NOTE: These are actually not required but extend the functionality of treesitter
      requires = {
        "nvim-treesitter/nvim-treesitter-refactor", -- Rename variables when lsp is not available and navigate through blocks of code
        "nvim-treesitter/nvim-treesitter-textobjects", -- Move text objects intelligently
        "windwp/nvim-ts-autotag", -- Automatically close and rename tags
        "p00f/nvim-ts-rainbow", -- Rainbow brackets
        "JoosepAlviste/nvim-ts-context-commentstring", -- Change the comment string according to the location of the cursor in the file
      },
    })

    -- Auto pairs for "(", "[", "{", etc
    -- use {
    -- "windwp/nvim-autopairs",
    -- config = function()
    -- require("plugins.configs.autopairs")
    -- end,
    -- after = "nvim-compe"
    -- }
    use("jiangmiao/auto-pairs")

    -- Themes
    use("folke/tokyonight.nvim")
    -- use "ayu-theme/ayu-vim"

    -- Status Line
    use({
      "hoob3rt/lualine.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("plugins.configs.lualine")
      end,
    })

    -- Git
    use("tpope/vim-fugitive")
    use({ "junegunn/gv.vim", requires = "tpope/vim-fugitive" })
    use({
      "rhysd/git-messenger.vim",
      event = "BufRead",
      config = function()
        require("plugins.configs.git-messenger")
      end,
    })
    use({
      "lewis6991/gitsigns.nvim",
      requires = "nvim-lua/plenary.nvim",
      event = "BufRead",
      config = function()
        require("plugins.configs.gitsigns")
      end,
    })
    use({
      "f-person/git-blame.nvim",
      event = "BufRead",
      config = function()
        require("plugins.configs.git-blame")
      end,
    })
    -- use {
    -- "TimUntersberger/neogit",
    -- requires = "nvim-lua/plenary.nvim",
    -- config = function()
    -- require("plugins.configs.neogit")
    -- end
    -- }

    -- Terminal
    use({
      "numtostr/FTerm.nvim",
      event = "BufRead",
      config = function()
        require("plugins.configs.fterm")
      end,
    })

    -- Start Screen
    use({
      "glepnir/dashboard-nvim",
      config = function()
        require("plugins.configs.dashboard")
      end,
    })
    -- use {"mhinz/vim-startify", config = function() require("plugins.configs.startify") end}

    -- See what keys do like in emacs
    -- use "liuchengxu/vim-which-key"
    -- Lua version of vim-which-key
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
        require("plugins.configs.vsnip")
      end,
    })
    use({ "rafamadriz/friendly-snippets", event = "InsertEnter" })

    -- Interactive code
    use({
      "metakirby5/codi.vim",
      cmd = "Codi",
      config = function()
        require("plugins.configs.codi")
      end,
    })

    -- Better tabline
    use({
      "akinsho/nvim-bufferline.lua",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("plugins.configs.bufferline")
      end,
    })

    -- Better quickfix menu
    use({
      "kevinhwang91/nvim-bqf",
      config = function()
        require("plugins.configs.bqf")
      end,
    })
    use({
      "folke/lsp-trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      cmd = { "TroubleToggle", "Telescope" },
      config = function()
        require("plugins.configs.trouble")
      end,
    })

    -- Intuitive buffer closing
    use({ "famiu/bufdelete.nvim", event = "BufEnter" })

    -- Undo time travel
    use({ "mbbill/undotree", event = "BufEnter" })

    -- Smooth scroll
    use({ "psliwka/vim-smoothie", event = "BufEnter" })

    -- Swap windows
    use({
      "wesQ3/vim-windowswap",
      event = "BufEnter",
      config = function()
        require("plugins.configs.windowswap")
      end,
    })

    -- Markdown Preview
    use({ "npxbr/glow.nvim", run = ":GlowInstall", ft = { "markdown", "markdownreact" } })

    -- Colorizer
    use({
      "norcalli/nvim-colorizer.lua",
      event = "BufRead",
      config = function()
        require("plugins.configs.colorizer")
      end,
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
    })

    -- Intellisense
    use({ "neovim/nvim-lspconfig" })
    use({ "kabouzeid/nvim-lspinstall" })
    use({
      "hrsh7th/nvim-compe",
      config = function()
        require("plugins.configs.compe")
      end,
      event = "InsertEnter",
    })
    use({
      "glepnir/lspsaga.nvim",
      config = function()
        require("plugins.configs.lspsaga")
      end,
      event = "BufRead",
    })
    use({ "RishabhRD/nvim-lsputils", requires = { "RishabhRD/popfix" } })
    use({
      "simrat39/symbols-outline.nvim",
      cmd = "SymbolsOutline",
      config = function()
        require("plugins.configs.symbols-outline")
      end,
    })
    use({
      "fatih/vim-go",
      ft = { "go" },
      config = function()
        require("plugins.configs.vim-go")
      end,
      run = function()
        vim.cmd("GoUpdateBinaries")
      end,
    })
    use({
      "ray-x/lsp_signature.nvim",
      event = "InsertEnter",
      config = function()
        require("plugins.configs.lsp_signature")
      end,
    })
    use({ "folke/lsp-colors.nvim", event = "BufRead" })

    -- Markdown preview
    use({
      "iamcco/markdown-preview.nvim",
      ft = { "markdown", "markdownreact" },
      run = "cd app && npm install",
      config = function()
        require("plugins.configs.markdown-preview")
      end,
    })

    -- Easily change surrounding elements
    use({ "tpope/vim-surround", event = "BufRead" })

    -- Extend increment/decrement functionality
    use({
      "monaqa/dial.nvim",
      event = "BufRead",
      config = function()
        require("plugins.configs.dial")
      end,
    })

    -- Better bookmarks
    use({
      "MattesGroeger/vim-bookmarks",
      config = function()
        require("plugins.configs.bookmarks")
      end,
    })

    -- Interact with databases
    use("tpope/vim-dadbod")
    use({
      "kristijanhusak/vim-dadbod-ui",
      config = function()
        require("plugins.configs.dadbod")
      end,
    })
    use("kristijanhusak/vim-dadbod-completion")

    -- Jump to lines more interactively
    use({
      "nacro90/numb.nvim",
      event = "BufRead",
      config = function()
        require("plugins.configs.numb")
      end,
    })

    -- Distraction free writing (zen mode)
    use({
      "folke/zen-mode.nvim",
      cmd = "ZenMode",
      config = function()
        require("plugins.configs.zen-mode")
      end,
    })

    -- The emmet plugin for vim
    use({
      "mattn/emmet-vim",
      event = "InsertEnter",
      config = function()
        require("plugins.configs.emmet")
      end,
    })

    -- Run selected blocks of code
    use({
      "michaelb/sniprun",
      run = "bash ./install.sh",
      config = function()
        require("sniprun").initial_setup()
        require("plugins.configs.sniprun")
      end,
    })

    use({
      "andymass/vim-matchup",
      event = "CursorMoved",
      config = function()
        require("plugins.configs.matchup")
      end,
    })

    use({
      "windwp/nvim-spectre",
      requires = { "nvim-lua/plenary.nvim", "nvim-lua/popup.nvim" },
      event = "BufRead",
      config = function()
        require("plugins.configs.spectre")
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
