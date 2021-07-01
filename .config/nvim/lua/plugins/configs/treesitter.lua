require("nvim-treesitter.configs").setup({
    ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    ignore_install = {},
    highlight = {
        enable = true -- false will disable the whole extension
    },
    rainbow = { enable = true }, -- Rainbow brackets
    context_commentstring = { enable = true }, -- Comment strings
    -- refactor = {highlight_definitions = {enable = true}}, -- Highlight all the occurrences of variables under the cursor
    autotag = { enable = true },
    indent = { enable = true },
    autopairs = { enable = true },
    matchup = { enable = true } -- Extend vim's '%' functionality
})

