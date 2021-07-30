local window = require("ui.window")

local peek = {
  floating_buf = nil,
  floating_win = nil,
  prev_result = nil,
}

local function preview_location_callback(_, method, result)
  if result == nil or vim.tbl_isempty(result) then
    print("peek: No location found: " .. method)
    return nil
  end

  local opts = {
    border = "rounded",
    context = 10,
  }

  if vim.tbl_islist(result) then
    peek.prev_result = result[1]
    peek.floating_buf, peek.floating_win = window.create_floating_file(result[1], opts)
  else
    peek.prev_result = result
    peek.floating_buf, peek.floating_win = window.create_floating_file(result, opts)
  end
end

function peek.OpenFile()
  -- Get the file currently open in the floating window
  local filepath = vim.fn.expand("%:.")

  if not filepath then
    print("peek: Unable to open the file!")
    return
  end

  -- Close the floating window
  pcall(vim.api.nvim_win_close, peek.floating_win, true)

  -- Edit the file
  vim.cmd("edit " .. filepath)

  local winnr = vim.api.nvim_get_current_win()

  -- Set the cursor at the right position
  peek.SetCursorToPrevPos(winnr)
end

function peek.SetCursorToPrevPos(winnr)
  -- Get position of the thing to peek at
  local location = peek.prev_result
  local range = location.targetRange or location.range
  local cursor_pos = { range.start.line + 1, range.start.character }

  -- Set the winnr to the floting window if none was passed in
  winnr = winnr or peek.floating_win
  -- Set the cursor at the correct position in the floating window
  vim.api.nvim_win_set_cursor(winnr, cursor_pos)
end

function peek.Peek(what)
  -- If a window already exists, focus it at the right position!
  if vim.tbl_contains(vim.api.nvim_list_wins(), peek.floating_win) then
    local success_1, _ = pcall(vim.api.nvim_set_current_win, peek.floating_win)
    if not success_1 then
      print("peek: You cannot edit the current file in a preview!")
      return
    end

    -- Set the cursor at the correct position in the floating window
    peek.SetCursorToPrevPos()

    vim.api.nvim_buf_set_keymap(
      peek.floating_buf,
      "n",
      "<CR>",
      ":lua require('ui.peek').OpenFile()<CR>",
      { noremap = true, silent = true }
    )
  else
    -- Make a new request and then create the new window in the callback
    local params = vim.lsp.util.make_position_params()
    local success, _ = pcall(vim.lsp.buf_request, 0, "textDocument/" .. what, params, preview_location_callback)
    if not success then
      print(
        'peek: Error calling LSP method "textDocument/' .. what .. '". The current language lsp might not support it.'
      )
    end
  end
end

return peek
