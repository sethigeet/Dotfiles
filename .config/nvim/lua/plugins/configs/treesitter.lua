require("nvim-treesitter.configs").setup(
    {
        ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
        highlight = {
            enable = true -- false will disable the whole extension
        },
        playground = {
            enable = true,
            disable = {},
            updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
            persist_queries = false -- Whether the query persists across vim sessions
        },
        rainbow = {enable = true}, -- Rainbow brackets
        -- refactor = {highlight_definitions = {enable = true}}, -- Highlight all the occurrences of variables under the cursor
        autotag = {enable = true},
        indent = {enable = true}
    })

vim.cmd("set foldmethod=expr")
vim.cmd("set foldexpr=nvim_treesitter#foldexpr()")
