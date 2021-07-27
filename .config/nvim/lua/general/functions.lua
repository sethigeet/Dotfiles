function LoadPlugins(doWhat, args)
  local plugins = require("plugins.plugins")
  require("utils.plugin_wrapper").setup(plugins.config, plugins.plugins)

  if not doWhat then
    return
  end

  if type(doWhat) ~= "string" then
    error("The argument must be a string")
  end

  local doWhatSwitch = {
    sync = "PackerSync",
    compile = "PackerCompile",
    install = "PackerInstall",
    update = "PackerUpdate",
    profile = "PackerProfile",
    load = "PackerLoad " .. (args or ""),
  }
  if doWhatSwitch[doWhat] then
    vim.cmd(doWhatSwitch[doWhat])
    return
  end

  error("That action is not supported")
end

function SaveFile(format, force)
  -- Format the file
  if format then
    vim.lsp.buf.formatting()
  end

  -- Save the file
  if force then
    vim.cmd("write!")
  else
    vim.cmd("write")
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
