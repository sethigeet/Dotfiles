require("bufferline").setup({
    options = {
        numbers = "none",
        mappings = true,
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

