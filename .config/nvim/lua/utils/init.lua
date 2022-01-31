local utils = {}
local fn = vim.fn

function utils.t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

---@param keys string keys to feed
--- Replace keys with termcodes and feed them
function utils.feed(keys)
  vim.api.nvim_feedkeys(utils.t(keys), "n", true)
end

function utils.check_back_space()
  local col = vim.fn.col(".") - 1
  if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
    return true
  else
    return false
  end
end

function utils.has_words_before()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- Why is this not a built-in Vim script function?
function utils.get_visual_selection(allowCurrLine, join)
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

function utils.restore_last_place()
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

function utils.get_relative_path(path)
  local split_path = vim.split(path, "/")
  local split_cwd = vim.split(vim.fn.getcwd(), "/")
  local curr_dir = split_cwd[#split_cwd]
  local nice_path = ""

  local ok = false
  for _, dir in ipairs(split_path) do
    if dir == curr_dir then
      ok = true
    end
    if ok then
      nice_path = nice_path .. "/" .. dir
    end
  end

  return "." .. nice_path
end

return utils
