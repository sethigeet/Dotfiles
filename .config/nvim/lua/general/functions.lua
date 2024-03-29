function ReloadFile()
  vim.notify(
    [[The current file will be sourced and will be
loading in the runtime again]],
    vim.log.levels.INFO,
    {
      title = "Reloading current file",
    }
  )

  if vim.opt.filetype:get() == "vim" then
    vim.cmd("silent! write")
    vim.cmd("source %")
  elseif vim.opt.filetype:get() == "lua" then
    vim.cmd("silent! write")
    vim.cmd("luafile %")
  end
end

-- NOTE: The part ahead requires `nvim-treesitter` plugin to be installed!
vim.treesitter.query.set(
  "lua",
  "SaveAndExec_Lua_Result",
  [[
(
  (function_declaration
    name: (identifier) @capture)
)
]]
)

function SaveAndExec(save)
  if save then ReloadFile() end

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
    vim.notify(
      "Unable to find any global function under the cursor",
      vim.log.levels.ERROR,
      { title = "An error occurred" }
    )
    return
  end

  local query = vim.treesitter.query.get("lua", "SaveAndExec_Lua_Result")
  for _, node in query:iter_captures(function_node, 0) do
    local fn_name = vim.treesitter.get_node_text(node, 0)
    vim.notify("Executing the global function found under the cursor: '" .. fn_name .. "'", vim.log.levels.INFO, {
      title = "Executing '" .. fn_name .. "'",
    })
    vim.cmd("lua " .. fn_name .. "()")
    break
  end
end
