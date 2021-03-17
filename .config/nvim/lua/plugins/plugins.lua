local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    execute("!git clone https://github.com/wbthomason/packer.nvim " ..
                install_path)
    execute "packadd packer.nvim"
end

return require("packer").startup(function(use)
    -- Packer can manage itself as an optional plugin
    use "wbthomason/packer.nvim"

    -- Easier Comments
    use {
        "tpope/vim-commentary",
        config = function() require("plugins.configs.vim-commentary") end
    }
    use "suy/vim-context-commentstring" -- Useful for React Commenting
    use "jbgutierrez/vim-better-comments" -- Highlights comments

    -- Indent lines
    use {
        "Yggdroot/indentLine",
        config = function() require("plugins.configs.indentLine") end
    }

    -- Change dates fast
    use "tpope/vim-speeddating"

    -- Repeat stuff
    use "tpope/vim-repeat"

    -- Text Navigation
    use {
        "unblevable/quick-scope",
        config = function() require("plugins.configs.quickscope") end
    }

    -- highlight all matches under cursor
    use {
        "RRethy/vim-illuminate",
        config = function() require("plugins.configs.illuminate") end
    }

    -- Vifm
    use {
        "vifm/vifm.vim",
        config = function() require("plugins.configs.vifm") end
    }

    -- File Explorer
    use {
        "kyazdani42/nvim-tree.lua",
        config = function() require("plugins.configs.nvimtree") end
    }

    -- Easymotion
    use {
        "easymotion/vim-easymotion",
        config = function() require("plugins.configs.easymotion") end
    }

    -- Surround
    use "tpope/vim-surround"

    -- Have the file system follow you around
    use {
        "airblade/vim-rooter",
        config = function() require("plugins.configs.vim-rooter") end
    }

    -- auto set indent settings
    use "tpope/vim-sleuth"

    -- Better Syntax Support
    use {
        "sheerun/vim-polyglot",
        config = function() require("plugins.configs.polyglot") end
    }

    -- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        config = function() require("plugins.configs.treesitter") end
    }
    use "nvim-treesitter/playground"

    -- Cool Icons
    use "kyazdani42/nvim-web-devicons"
    use "ryanoasis/vim-devicons"

    -- Auto pairs for "(" "[" "{"
    use "jiangmiao/auto-pairs"

    -- Closetags
    use {
        "alvan/vim-closetag",
        config = function() require("plugins.configs.closetags") end
    }
    -- Auto change html tags
    use {
        "AndrewRadev/tagalong.vim",
        config = function() require("plugins.configs.tagalong") end
    }

    -- Themes
    use "ayu-theme/ayu-vim"

    -- Status Line
    use {
        "glepnir/galaxyline.nvim",
        config = function() require("plugins.configs.galaxyline") end
    }

    -- Git
    use {
        "airblade/vim-gitgutter",
        config = function() require("plugins.configs.gitgutter") end
    }
    use "tpope/vim-fugitive"
    use "junegunn/gv.vim"
    use {
        "rhysd/git-messenger.vim",
        config = function() require("plugins.configs.git-messenger") end
    }

    -- Terminal
    use {
        "voldikss/vim-floaterm",
        config = function() require("plugins.configs.floaterm") end
    }

    -- Start Screen
    use {
        "mhinz/vim-startify",
        config = function() require("plugins.configs.startify") end
    }

    -- See what keys do like in emacs
    use "liuchengxu/vim-which-key"

    -- Snippets
    use "norcalli/snippets.nvim"
    use "mattn/emmet-vim"

    -- Interactive code
    use {
        "metakirby5/codi.vim",
        config = function() require("plugins.configs.codi") end
    }

    -- Better tabline
    use {
        "romgrk/barbar.nvim",
        config = function() require("plugins.configs.barbar") end
    }

    -- Intuitive buffer closing
    use "moll/vim-bbye"

    -- undo time travel
    use "mbbill/undotree"

    -- Smooth scroll
    use "psliwka/vim-smoothie"

    -- Swap windows
    use {
        "wesQ3/vim-windowswap",
        config = function() require("plugins.configs.window-swap") end
    }

    -- Markdown Preview
    use {'npxbr/glow.nvim', run = ':GlowInstall'}

    -- Colorizer
    use {
        "norcalli/nvim-colorizer.lua",
        config = function() require("plugins.configs.colorizer") end
    }

    -- Neovim in Browser
    use {
        "glacambre/firenvim",
        run = function() vim.fn["firenvim#install"](1) end,
        config = function() require("plugins.configs.firenvim") end

    }

    -- Rainbow brackets
    use "p00f/nvim-ts-rainbow"
    -- use "maxmellon/vim-jsx-pretty"
    --
    -- Multiple Cursors
    use "terryma/vim-multiple-cursors"

    -- Telescope
    use {
        "nvim-telescope/telescope.nvim",
        requires = {
            "nvim-lua/plenary.nvim", "nvim-lua/popup.nvim",
            "nvim-telescope/telescope-media-files.nvim"
        },
        config = function() require("plugins.configs.telescope") end
    }

    -- Intellisense
    use "neovim/nvim-lspconfig"
    use {
        "hrsh7th/nvim-compe",
        config = function() require("plugins.configs.compe") end
    }
    use {
        "glepnir/lspsaga.nvim",
        config = function() require("plugins.configs.lspsaga") end
    }
    use "onsails/lspkind-nvim"
    use {
        "kosayoda/nvim-lightbulb",
        config = function() require("plugins.configs.lightbulb") end
    }
    use "liuchengxu/vista.vim"
end)
