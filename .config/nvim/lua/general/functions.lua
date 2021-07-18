local function DefineAugroups(definitions)
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
      local command = table.concat(vim.tbl_flatten({ "autocmd", def }), " ")
      vim.cmd(command)
    end

    vim.cmd("augroup END")
  end
end

local function t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local function checkBackSpace()
  local col = vim.fn.col(".") - 1
  if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
    return true
  else
    return false
  end
end

function _G.TabComplete()
  if vim.fn.pumvisible() == 1 then
    return t("<C-n>")
  elseif vim.fn.call("vsnip#available", { 1 }) == 1 then
    return t("<Plug>(vsnip-expand-or-jump)")
  elseif checkBackSpace() then
    return t("<Tab>")
  else
    -- return vim.fn["compe#complete"]()
    return vim.fn["emmet#expandAbbrIntelligent"]("\\<Tab>")
  end
end

function _G.STabComplete()
  if vim.fn.pumvisible() == 1 then
    return t("<C-p>")
  elseif vim.fn.call("vsnip#jumpable", { -1 }) == 1 then
    return t("<Plug>(vsnip-jump-prev)")
  else
    return t("<S-Tab>")
  end
end

function ToggleQFList(global)
  if global == 1 then
    if vim.fn.exists("g:quickfix_list_open") == 1 then
      if vim.g.quickfix_list_open == 1 then
        vim.g.quickfix_list_open = 0
        vim.cmd("TroubleClose")
      else
        vim.g.quickfix_list_open = 1
        vim.cmd("Trouble quickfix")
      end
    else
      vim.cmd("let g:quickfix_list_open = 1")
      vim.cmd("Trouble quickfix")
    end
  else
    if vim.fn.exists("g:location_list_open") == 1 then
      if vim.g._location_list_open == 1 then
        vim.g.location_list_open = 0
        vim.cmd("TroubleClose")
      else
        vim.g.location_list_open = 1
        vim.cmd("Trouble loclist")
      end
    else
      vim.cmd("let g:location_list_open = 1")
      vim.cmd("Trouble loclist")
    end
  end
end

function ReloadFile()
  if vim.opt.filetype == "vim" then
    vim.cmd("silent! write")
    vim.cmd("source %")
  elseif vim.opt.filetype == "lua" then
    vim.cmd("silent! write")
    vim.cmd("luafile %")
  end
end

return { DefineAugroups = DefineAugroups }
