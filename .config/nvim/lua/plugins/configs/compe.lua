vim.cmd("set shortmess+=c")
vim.o.completeopt = "menuone,noselect"

require("compe").setup {
    enabled = true,
    autocomplete = true,
    debug = false,
    min_length = 1,
    preselect = "enable",
    throttle_time = 80,
    source_timeout = 200,
    incomplete_delay = 400,
    allow_prefix_unmatch = false,
    max_abbr_width = 1000,
    max_kind_width = 1000,
    max_menu_width = 1000000,
    documentation = true,

    source = {
        path = {kind = "  "},
        buffer = {kind = "  "},
        calc = {kind = "  "},
        vsnip = {kind = "  "},
        nvim_lsp = {kind = "  "},
        nvim_lua = {kind = "  "},
        spell = {kind = "  "},
        tags = false,
        snippets_nvim = {kind = "  "},
        treesitter = {kind = "  "},
        emoji = {kind = " ﲃ "}
        -- for emoji press : (idk if that in compe tho)
    }
}

vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<CR>", "compe#confirm('<CR>')",
                        {expr = true, silent = true})
vim.api.nvim_set_keymap("i", "<C-Space>", "compe#complete()",
                        {expr = true, silent = true})
