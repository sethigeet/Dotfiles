local M = {}

function M.define_augroups(definitions)
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

function M.map(mode, lhs, rhs, opts)
  opts = opts or {}
  if opts.silent == nil then
    opts.silent = true
  end

  vim.keymap.set(mode, lhs, rhs, opts)
end

function M.highlight(group, color)
  if color.link then
    vim.cmd("highlight! link " .. group .. " " .. color.link)
    return
  end

  local style = color.gui and "gui=" .. color.style or "gui=NONE"
  local fg = color.fg and "guifg=" .. color.fg or "guifg=NONE"
  local bg = color.bg and "guibg=" .. color.bg or "guibg=NONE"
  local sp = color.sp and "guisp=" .. color.sp or ""
  vim.cmd(string.format("highlight %s %s %s %s %s", group, style, fg, bg, sp))
end

function M.highlight_groups(groups)
  for group, colors in pairs(groups) do
    M.highlight(group, colors)
  end
end

return M
