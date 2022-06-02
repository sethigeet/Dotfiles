local M = {}

function M.define_augroups(definitions)
  for group_name, definition in pairs(definitions) do
    -- create the group
    vim.api.nvim_create_augroup(group_name, { clear = true })

    -- create the commands
    for _, def in ipairs(definition) do
      vim.api.nvim_create_autocmd(
        def[1],
        { group = group_name, pattern = def[2], callback = def.cb, command = def.cmd, once = def.once }
      )
    end
  end
end

function M.map(mode, lhs, rhs, opts)
  opts = opts or {}
  if opts.silent == nil then
    opts.silent = true
  end

  vim.keymap.set(mode, lhs, rhs, opts)
end

function M.highlight(group, colors)
  vim.api.nvim_set_hl(0, group, colors)
end

function M.highlight_groups(groups)
  for group, colors in pairs(groups) do
    M.highlight(group, colors)
  end
end

return M
