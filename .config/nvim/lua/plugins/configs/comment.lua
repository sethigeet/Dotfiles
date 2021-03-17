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

require('nvim_comment').setup({
    -- Linters prefer comment and line to have a space in between markers
    marker_padding = true,
    -- should comment out empty or whitespace only lines
    comment_empty = false,
    -- Should key mappings be created
    create_mappings = false,
    -- Normal mode mapping left hand side
    line_mapping = "gcc",
    -- Visual/Operator mapping left hand side
    operator_mapping = "gc"
})

function _G.Comment()
    if vim.fn.mode() == "n" then
        vim.cmd("CommentToggle")
    else
        vim.cmd("'<,'>CommentToggle")
    end
end

vim.api.nvim_set_keymap("v", "<space>/", "v:lua.Comment()",
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<space>/", "v:lua.Comment()",
                        {noremap = true, silent = true})
