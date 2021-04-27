local npairs = require("nvim-autopairs")
npairs.setup({
    check_ts = true,
    ts_config = {
        lua = { "string" }, -- it will not add pair on that treesitter node
        javascript = { "template_string" }
    }
})

-- skip it, if you use another global object
_G.AutoPairUtils = {}

vim.g.completion_confirm_key = ""
AutoPairUtils.completion_confirm = function()
    if vim.fn.pumvisible() ~= 0 then
        if vim.fn.complete_info()["selected"] ~= -1 then
            return vim.fn["compe#confirm"](npairs.esc("<CR>"))
        else
            return npairs.esc("<CR>")
        end
    else
        return npairs.autopairs_cr()
    end
end

vim.api.nvim_set_keymap("i", "<CR>", "v:lua.MUtils.completion_confirm()",
                        { expr = true, noremap = true })

