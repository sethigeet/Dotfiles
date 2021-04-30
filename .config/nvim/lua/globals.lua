CONFIG_PATH = vim.fn.stdpath("config")
DATA_PATH = vim.fn.stdpath("data")
CACHE_PATH = vim.fn.stdpath("cache")

Opts = {
    -- Lines and numbers
    wrap_lines = false,
    number = true,
    relative_number = true,

    -- Colorscheme
    colorscheme = "ayu",

    -- Tree
    auto_close_tree = 1,

    -- Default shell
    shell = "zsh",

    -- Auto complete
    auto_complete = true,

    -- Treesitter
    treesitter = {
        ensure_installed = "all",
        ignore_install = {},
        highlight = { enable = true },
        rainbow = { enable = true },
        autotag = { enable = true },
        indent = { enable = true },
        autopairs = { enable = true }
    },

    -- Database Interaction
    database = { save_location = DATA_PATH .. "/dadbod.db", auto_execute = true },

    -- LSP
    lsp = {
        efm_langserver = {
            autoformat = true,
            diagnostics = { virtual_text = true, signs = true, underline = true }
        },
        python = {
            autoformat = true,
            diagnostics = { virtual_text = true, signs = true, underline = true }
        },
        lua = {
            autoformat = true,
            diagnostics = { virtual_text = true, signs = true, underline = true }
        },
        sh = {
            autoformat = true,
            diagnostics = { virtual_text = true, signs = true, underline = true }
        },
        typescript = {
            autoformat = true,
            diagnostics = { virtual_text = true, signs = true, underline = true }
        },
        json = {
            autoformat = true,
            diagnostics = { virtual_text = true, signs = true, underline = true }
        },
        html = {
            autoformat = true,
            diagnostics = { virtual_text = true, signs = true, underline = true }
        },
        css = {
            autoformat = true,
            diagnostics = { virtual_text = true, signs = true, underline = true }
        },
        emmet = {
            autoformat = true,
            diagnostics = { virtual_text = true, signs = true, underline = true }
        },
        docker = {
            autoformat = true,
            diagnostics = { virtual_text = true, signs = true, underline = true }
        },
        go = {
            autoformat = true,
            diagnostics = { virtual_text = true, signs = true, underline = true }
        },
        graphql = {
            autoformat = true,
            diagnostics = { virtual_text = true, signs = true, underline = true }
        },
        vim = {
            autoformat = true,
            diagnostics = { virtual_text = true, signs = true, underline = true }
        },
        yaml = {
            autoformat = true,
            diagnostics = { virtual_text = true, signs = true, underline = true }
        }
    },

    -- Git
    git = { show_blame = true, show_signs = true }
}

