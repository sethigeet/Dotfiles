local M = {}

function M.map(mode, lhs, rhs, opts)
  opts = opts or {}
  if vim.tbl_isempty(opts) or opts.silent == nil then
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
