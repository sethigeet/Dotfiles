local function define_augroups(definitions)
    -- Create autocommand groups based on the passed definitions
    --
    -- The key will be the name of the group, and each definition
    -- within the group should have:
    --    1. Trigger
    --    2. Pattern
    --    3. Text
    -- just like how they would normally be defined from Vim itself
    for group_name, definition in pairs(definitions) do
        vim.cmd("augroup " .. group_name)
        vim.cmd("autocmd!")

        for _, def in pairs(definition) do
            local command = table.concat(vim.tbl_flatten { "autocmd", def }, " ")
            vim.cmd(command)
        end

        vim.cmd("augroup END")
    end
end

local function t(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col(".") - 1
    if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
        return true
    else
        return false
    end
end

function _G.smart_tab()
    return vim.fn.pumvisible() == 1 and t("<C-n>") or t("<Tab>")
end

_G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t("<C-n>")
    elseif vim.fn.call("vsnip#available", { 1 }) == 1 then
        return t("<Plug>(vsnip-expand-or-jump)")
    elseif check_back_space() then
        return t("<Tab>")
    else
        -- return vim.fn["compe#complete"]()
        return vim.fn["emmet#expandAbbrIntelligent"]("\\<Tab>")
    end
end

function _G.s_tab_complete()
    if vim.fn.pumvisible() == 1 then
        return t("<C-p>")
    elseif vim.fn.call("vsnip#jumpable", { -1 }) == 1 then
        return t("<Plug>(vsnip-jump-prev)")
    else
        return t("<S-Tab>")
    end
end

return { define_augroups = define_augroups }
