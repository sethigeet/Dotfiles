require("bufferline").setup({
    options = {
        numbers = "none",
        mappings = false,
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(_, _, diagnostics_dict)
            local s = " "
            for e, n in pairs(diagnostics_dict) do
                local sym
                if e == "error" then
                    sym = " "
                elseif e == "warning" then
                    sym = " "
                elseif e == "info" then
                    sym = " "
                else
                    sym = " "
                end
                s = s .. n .. sym
            end
            return s
        end,
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        separator_style = "thick"
    }
})

vim.api.nvim_set_keymap("n", "<C-b>", ":BufferLinePick<CR>", { noremap = true, silent = true })

-- Move to a buffer using Alt+number
for i = 1, 9, 1 do
    vim.api.nvim_set_keymap("n", "<M-" .. i .. ">",
                            ":lua require('bufferline').go_to_buffer(" .. i .. ")<CR>",
                            { noremap = true, silent = true })
end
