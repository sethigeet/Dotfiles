local M = {}

--[[
Output: {
  "   Auto Fix <C-o>  Apply <C-e> Exit",
  "[1] Disable diagnostics in the workspace (unused-local).",
  "[2] Disable diagnostics on this line (unused-local).",
  "[3] Disable diagnostics in this file (unused-local)."
}
--]]
function M.handler(err, _, actions, _, bufnr, _, customSelectionHandler)
  if err then
    error("An error occurred!\n" .. err)
  end

  if actions == nil or vim.tbl_isempty(actions) then
    print("No code actions available")
    return
  end

  local data = { "   Auto Fix  <C-o> Apply <C-e> Exit" }

  for i, action in ipairs(actions) do
    local title = action.title:gsub("\r\n", "\\r\\n")
    title = title:gsub("\n", "\\n")
    title = string.format("[%d] %s", i, title)
    table.insert(data, title)
    actions[i].display_title = title
  end
  local width = 0
  for _, str in ipairs(data) do
    if #str > width then
      width = #str
    end
  end

  local function apply_action(action)
    local action_chosen = nil
    for _, value in pairs(actions) do
      if value.display_title == action then
        action_chosen = value
      end
    end
    local switch = string.format("silent b %d", bufnr)
    if action_chosen.edit or type(action_chosen.command) == "table" then
      if action_chosen.edit then
        vim.lsp.util.apply_workspace_edit(action_chosen.edit)
      end
      if type(action_chosen.command) == "table" then
        -- switch buff
        vim.cmd(switch)
        vim.lsp.buf.execute_command(action_chosen.command)
      end
    else
      vim.cmd(switch)
      vim.lsp.buf.execute_command(action_chosen)
    end
  end

  print(vim.inspect(data))
  -- gui.new_list_view({
  -- items = data,
  -- width = width + 4,
  -- loc = "top_center",
  -- relative = "cursor",
  -- rawdata = true,
  -- data = data,
  -- on_confirm = function(pos)
  -- apply_action(pos)
  -- end,
  -- on_move = function(pos)
  -- return pos
  -- end,
  -- })
end

return M
