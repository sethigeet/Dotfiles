local utils = {}
local fn = vim.fn

function utils.DefineAugroups(definitions)
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

function utils.t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function utils.checkBackSpace()
  local col = vim.fn.col(".") - 1
  if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
    return true
  else
    return false
  end
end

-- Why is this not a built-in Vim script function?
function utils.getVisualSelection(allowCurrLine, join)
  local start_coordinates = vim.fn.getpos("'<")
  local line_start = start_coordinates[2]

  local end_coordinates = vim.fn.getpos("'>")
  local line_end = end_coordinates[2]

  local lines = vim.fn.getline(line_start, line_end)
  if vim.fn.len(lines) == 0 then
    if allowCurrLine then
      return vim.fn.getline(".")
    end

    return ""
  end

  return join and vim.fn.join(lines, "\n") or lines
end

function utils.restoreLastPlace()
  local ignore_buftypes = { "quickfix", "nofile", "help" }
  local ignore_filetypes = { "gitcommit", "gitrebase", "svn", "hgcommit" }

  -- Check if buffer should be ignored
  if
    vim.tbl_contains(ignore_buftypes, vim.api.nvim_buf_get_option(0, "buftype"))
    or vim.tbl_contains(ignore_filetypes, vim.api.nvim_buf_get_option(0, "filetype"))
  then
    return
  end

  -- If the last line is set and the less than the last line in the buffer
  if fn.line([['"]]) > 0 and fn.line([['"]]) <= fn.line("$") then
    -- Check if the last line of the buffer is the same as the window
    if fn.line("w$") == fn.line("$") then
      -- Set line to last line edited
      vim.api.nvim_command([[normal! g`"]])
      -- Try to center
    elseif fn.line("$") - fn.line([['"]]) > ((fn.line("w$") - fn.line("w0")) / 2) - 1 then
      vim.api.nvim_command([[normal! g`"zz]])
    else
      vim.api.nvim_command([[normal! G'"<c-e>]])
    end
  end
  if fn.foldclosed(".") ~= -1 then
    vim.api.nvim_command([[normal! zvzz]])
  end
end

return utils
