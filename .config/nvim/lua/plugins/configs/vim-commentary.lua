local define_augroups = require("general.functions")

define_augroups({
    NerdCommenter = {
        {
            "FileType", "javascriptreact,typescriptreact",
            [[setlocal commentstring={/*\ %s\ */}]]
        },
        {
            "BufRead,BufNewFile", "*.{jsx,js}",
            "setlocal filetype=javascriptreact"
        },
        {"BufRead,BufNewFile", "*.{tsx}", "setlocal filetype=typescriptreact"}
    }
})

function _G.Comment()
    if vim.fn.mode() == "n" then
        vim.cmd("Commentary")
    else
        vim.cmd("'<,'>Commentary")
    end
end

vim.api.nvim_set_keymap("v", "<space>/", "v:lua.Comment()",
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<space>/", "v:lua.Comment()",
                        {noremap = true, silent = true})
