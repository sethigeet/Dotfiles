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

function ReloadFile()
  print("Reloading current file")
  if vim.opt.filetype:get() == "vim" then
    vim.cmd("silent! write")
    vim.cmd("source %")
  elseif vim.opt.filetype:get() == "lua" then
    vim.cmd("silent! write")
    vim.cmd("luafile %")
  end
end

-- NOTE: The part ahead requires `nvim-treesitter` plugin to be installed!
vim.treesitter.set_query(
  "lua",
  "SaveAndExec_Lua_Result",
  [[
   (function_name (*)) @capture
]]
)

function SaveAndExec(save)
  if save then
    ReloadFile()
  end

  local ts_locals = require("nvim-treesitter.locals")
  local ts_utils = require("nvim-treesitter.ts_utils")

  local cursor_node = ts_utils.get_node_at_cursor()
  local scope = ts_locals.get_scope_tree(cursor_node, 0)

  local function_node
  for _, v in ipairs(scope) do
    if v:type() == "function" then
      function_node = v
      break
    end
  end

  if not function_node then
    print("Unable to find any global function under the cursor")
    return
  end

  local query = vim.treesitter.get_query("lua", "SaveAndExec_Lua_Result")
  for _, node in query:iter_captures(function_node, 0) do
    local fn_name = vim.treesitter.get_node_text(node, 0)
    print("Executing '" .. fn_name .. "'")
    vim.cmd("lua " .. fn_name .. "()")
    break
  end
end

return { DefineAugroups = DefineAugroups }
