local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
    execute "packadd packer.nvim"
end

return require("packer").startup(function(use)
    -- Packer can manage itself as an optional plugin
    use "wbthomason/packer.nvim"

    -- Better Comments
    use {
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("plugins.configs.todo-comments")
        end
    }
    use "suy/vim-context-commentstring" -- Useful for React Commenting
    use {
        "terrortylor/nvim-comment",
        config = function()
            require("plugins.configs.comment")
        end
    }

    -- Indent lines
    use {
        "lukas-reineke/indent-blankline.nvim",
        branch = "lua",
        config = function()
            require("plugins.configs.indent-blankline")
        end
    }

    -- Repeat stuff
    use "tpope/vim-repeat"

    -- Vifm
    use {
        "vifm/vifm.vim",
        config = function()
            require("plugins.configs.vifm")
        end
    }

    -- File Explorer
    use {
        "kyazdani42/nvim-tree.lua",
        config = function()
            require("plugins.configs.nvim-tree")
        end,
        requires = "kyazdani42/nvim-web-devicons" -- Cool Icons
    }

    -- Easymotion
    use {
        "easymotion/vim-easymotion",
        config = function()
            require("plugins.configs.easymotion")
        end
    }

    -- Have the file system follow you around
    use {
        "airblade/vim-rooter",
        config = function()
            require("plugins.configs.rooter")
        end
    }

    -- auto set indent settings
    use "tpope/vim-sleuth"

    -- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("plugins.configs.treesitter")
        end,
        -- NOTE: These are actually not required but extend the functionality of treesitter
        requires = {
            "windwp/nvim-ts-autotag", -- Automatically close and rename tags
            "p00f/nvim-ts-rainbow", -- Rainbow brackets
            -- "nvim-treesitter/nvim-treesitter-refactor", -- Highlight all the occurrences of variables under the cursor
            "JoosepAlviste/nvim-ts-context-commentstring" -- Change the comment string according to the location of the cursor in the file
        }
    }

    -- Auto pairs for "(" "[" "{"
    -- use {
    -- "windwp/nvim-autopairs",
    -- config = function()
    -- require("plugins.configs.autopairs")
    -- end
    -- }
    use "jiangmiao/auto-pairs"

    -- Themes
    use "folke/tokyonight.nvim"
    use "ayu-theme/ayu-vim"

    -- Status Line
    use {
        "hoob3rt/lualine.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("plugins.configs.lualine")
        end
    }

    -- Git
    use "tpope/vim-fugitive"
    use { "junegunn/gv.vim", requires = "tpope/vim-fugitive" }
    use {
        "rhysd/git-messenger.vim",
        config = function()
            require("plugins.configs.git-messenger")
        end
    }
    use {
        "lewis6991/gitsigns.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("plugins.configs.gitsigns")
        end
    }
    use {
        "f-person/git-blame.nvim",
        config = function()
            require("plugins.configs.git-blame")
        end
    }
    -- use {
    -- "TimUntersberger/neogit",
    -- requires = "nvim-lua/plenary.nvim",
    -- config = function()
    -- require("plugins.configs.neogit")
    -- end
    -- }

    -- Terminal
    use {
        "voldikss/vim-floaterm",
        config = function()
            require("plugins.configs.floaterm")
        end
    }

    -- Start Screen
    use {
        "glepnir/dashboard-nvim",
        config = function()
            require("plugins.configs.dashboard")
        end
    }
    -- use {"mhinz/vim-startify", config = function() require("plugins.configs.startify") end}

    -- See what keys do like in emacs
    -- use "liuchengxu/vim-which-key"
    -- Lua version of vim-which-key
    use {
        "folke/which-key.nvim",
        config = function()
            require("plugins.configs.whichkey")
        end
    }

    -- Snippets
    use {
        "hrsh7th/vim-vsnip",
        requires = "hrsh7th/vim-vsnip-integ",
        config = function()
            require("plugins.configs.vsnip")
        end
    }
    use "rafamadriz/friendly-snippets"

    -- Interactive code
    use {
        "metakirby5/codi.vim",
        config = function()
            require("plugins.configs.codi")
        end
    }

    -- Better tabline
    use {
        "akinsho/nvim-bufferline.lua",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("plugins.configs.bufferline")
        end
    }

    -- Better quickfix menu
    use {
        "kevinhwang91/nvim-bqf",
        config = function()
            require("plugins.configs.bqf")
        end
    }
    use {
        "folke/lsp-trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("plugins.configs.trouble")
        end
    }

    -- Intuitive buffer closing
    use "moll/vim-bbye"

    -- Undo time travel
    use "mbbill/undotree"

    -- Smooth scroll
    use "psliwka/vim-smoothie"

    -- Swap windows
    use {
        "wesQ3/vim-windowswap",
        config = function()
            require("plugins.configs.windowswap")
        end
    }

    -- Markdown Preview
    use { "npxbr/glow.nvim", run = ":GlowInstall" }

    -- Colorizer
    use {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("plugins.configs.colorizer")
        end
    }

    -- Neovim in Browser
    use {
        "glacambre/firenvim",
        run = function()
            vim.fn["firenvim#install"](1)
        end,
        config = function()
            require("plugins.configs.firenvim")
        end

    }

    -- Multiple Cursors
    use "terryma/vim-multiple-cursors"

    -- Telescope
    use {
        "nvim-telescope/telescope.nvim",
        requires = {
            "nvim-lua/plenary.nvim", "nvim-lua/popup.nvim",
            "nvim-telescope/telescope-media-files.nvim", "nvim-telescope/telescope-fzy-native.nvim"
        },
        config = function()
            require("plugins.configs.telescope")
        end
    }

    -- Intellisense
    use { "neovim/nvim-lspconfig" }
    use { "kabouzeid/nvim-lspinstall" }
    use {
        "hrsh7th/nvim-compe",
        config = function()
            require("plugins.configs.compe")
        end
    }
    use {
        "glepnir/lspsaga.nvim",
        config = function()
            require("plugins.configs.lspsaga")
        end
    }
    use { "RishabhRD/nvim-lsputils", requires = { "RishabhRD/popfix" } }
    use {
        "simrat39/symbols-outline.nvim",
        config = function()
            require("plugins.configs.symbols-outline")
        end
    }
    use {
        "fatih/vim-go",
        config = function()
            require("plugins.configs.vim-go")
        end,
        run = function()
            vim.cmd("GoUpdateBinaries")
        end
    }
    use {
        "ray-x/lsp_signature.nvim",
        config = function()
            require("plugins.configs.lsp_signature")
        end
    }
    use "folke/lsp-colors.nvim"

    -- Markdown preview
    use {
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        config = function()
            require("plugins.configs.markdown-preview")
        end
    }

    -- Easily change surrounding elements
    use "tpope/vim-surround"

    -- Visually interact with the registers easily
    use "gennaro-tedesco/nvim-peekup"

    -- Extend increment/decrement functionality
    use {
        "monaqa/dial.nvim",
        config = function()
            require("plugins.configs.dial")
        end
    }

    -- Better bookmarks
    use {
        "MattesGroeger/vim-bookmarks",
        config = function()
            require("plugins.configs.bookmarks")
        end
    }

    -- Interact with databases
    use "tpope/vim-dadbod"
    use {
        "kristijanhusak/vim-dadbod-ui",
        config = function()
            require("plugins.configs.dadbod")
        end
    }
    use "kristijanhusak/vim-dadbod-completion"

    -- Jump to lines more interactively
    use {
        "nacro90/numb.nvim",
        config = function()
            require("plugins.configs.numb")
        end
    }

    -- Distraction free writing (zen mode)
    use {
        "folke/zen-mode.nvim",
        config = function()
            require("plugins.configs.zen-mode")
        end
    }

    -- The emmet plugin for vim
    use {
        "mattn/emmet-vim",
        config = function()
            require("plugins.configs.emmet")
        end
    }

    -- Run selected blocks of code
    use {
        "michaelb/sniprun",
        run = "bash ./install.sh",
        config = function()
            require"sniprun".initial_setup()
            require("plugins.configs.sniprun")
        end
    }
end)

