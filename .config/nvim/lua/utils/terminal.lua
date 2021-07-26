local terminal = {
  float_term_bufnr = nil,
  float_term_winnr = nil,
  cmd_pid = nil,
}

function terminal.toggle_floating(force, cmd)
  -- If window already exists, close it
  if terminal.float_term_winnr and vim.api.nvim_win_is_valid(terminal.float_term_winnr) then
    vim.api.nvim_win_close(terminal.float_term_winnr, {})
    terminal.float_term_winnr = nil

    if force and vim.api.nvim_buf_is_loaded(terminal.float_term_bufnr) then
      vim.api.nvim_buf_delete(terminal.float_term_bufnr, { force = true })
      terminal.float_term_bufnr = nil
    end

    if terminal.cmd_pid then
      vim.fn.jobstop(terminal.cmd_pid)
    end

    return
  end

  local bufnr
  if terminal.float_term_bufnr then
    bufnr = terminal.float_term_bufnr
  else
    bufnr = vim.api.nvim_create_buf(false, true)
  end
  local vpad = 4
  local hpad = 10
  local winnr = vim.api.nvim_open_win(bufnr, true, {
    relative = "editor",
    width = vim.o.columns - hpad * 2,
    height = vim.o.lines - vpad * 2,
    row = vpad,
    col = hpad,
    style = "minimal",
    border = "rounded",
  })
  vim.api.nvim_win_set_option(winnr, "winhl", "Normal:Normal")

  -- Run the cmd if the buffer did not exist previously
  if not terminal.float_term_bufnr then
    cmd = cmd or vim.opt.shell:get()
    terminal.cmd_pid = vim.fn.termopen(cmd)
  end
  vim.cmd("startinsert")

  -- Store the values for future
  terminal.float_term_bufnr = bufnr
  terminal.float_term_winnr = winnr
end

return terminal
