CONFIG_PATH = vim.fn.stdpath("config")
DATA_PATH = vim.fn.stdpath("data")
CACHE_PATH = vim.fn.stdpath("cache")

local defualtLspOpts = {
    autoformat = true,
    diagnostics = { virtual_text = { spacing = 0, prefix = "" }, signs = true, underline = true }
}

Opts = {
    -- Lines and numbers
    wrap_lines = false,
    number = true,
    relative_number = true,

    -- Min number of line to keep above and below the cursor
    scroll_off = 2,
    -- Minimal number of lines to keep on the right and the left side of the cursor
    side_scroll_off = 4,

    -- Colorscheme
    colorscheme = "tokyonight",

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
        efm_langserver = defualtLspOpts,
        python = defualtLspOpts,
        lua = defualtLspOpts,
        sh = defualtLspOpts,
        typescript = defualtLspOpts,
        json = defualtLspOpts,
        html = defualtLspOpts,
        css = defualtLspOpts,
        emmet = defualtLspOpts,
        docker = defualtLspOpts,
        go = defualtLspOpts,
        graphql = defualtLspOpts,
        vim = defualtLspOpts,
        yaml = defualtLspOpts
    },

    -- Git
    git = { show_blame = true, show_signs = true }
}

