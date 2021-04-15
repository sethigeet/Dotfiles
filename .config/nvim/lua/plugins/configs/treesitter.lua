require("nvim-treesitter.configs").setup({
    ensure_installed = Opts.treesitter.ensure_installed, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    ignore_install = Opts.treesitter.ignore_install,
    highlight = {
        enable = Opts.treesitter.highlight.enable -- false will disable the whole extension
    },
    rainbow = {enable = Opts.treesitter.rainbow.enable}, -- Rainbow brackets
    -- refactor = {highlight_definitions = {enable = true}}, -- Highlight all the occurrences of variables under the cursor
    autotag = {enable = Opts.treesitter.autotag.enable},
    indent = {enable = Opts.treesitter.indent.enable}
})

-- vim.cmd("set foldmethod=expr")
-- vim.cmd("set foldexpr=nvim_treesitter#foldexpr()")
