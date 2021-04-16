require("nvim-autopairs").setup()

local npairs = require("nvim-autopairs")

-- skip it, if you use another global object
_G.AutoPairUtils = {}

vim.g.completion_confirm_key = ""
AutoPairUtils.completion_confirm = function()
    if vim.fn.pumvisible() ~= 0 then
        if vim.fn.complete_info()["selected"] ~= -1 then
            vim.fn["compe#confirm"]()
            return npairs.esc("")
        else
            vim.api.nvim_select_popupmenu_item(0, false, false, {})
            vim.fn["compe#confirm"]()
            return npairs.esc("<c-n>")
        end
    else
        return npairs.check_break_line_char()
    end
end

AutoPairUtils.tab = function()
    if vim.fn.pumvisible() ~= 0 then
        return npairs.esc("<C-n>")
    else
        if vim.fn["vsnip#available"](1) ~= 0 then
            return vim.fn.feedkeys(string.format("%c%c%c(vsnip-expand-or-jump)", 0x80, 253, 83))
        else
            return npairs.esc("<Tab>")
        end
    end
end

AutoPairUtils.s_tab = function()
    if vim.fn.pumvisible() ~= 0 then
        return npairs.esc("<C-p>")
    else
        if vim.fn["vsnip#jumpable"](-1) ~= 0 then
            return vim.fn.feedkeys(string.format("%c%c%c(vsnip-jump-prev)", 0x80, 253, 83))
        else
            return npairs.esc("<C-h>")
        end
    end
end

vim.api.nvim_set_keymap("i", "<CR>", "v:lua.AutoPairUtils.completion_confirm()",
                        { expr = true, noremap = true })
vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.AutoPairUtils.tab()", { expr = true, noremap = true })
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.AutoPairUtils.s_tab()",
                        { expr = true, noremap = true })
