local window = {}

local function close_preview_autocmd(events, winnr)
  if #events > 0 then
    vim.api.nvim_command(
      "autocmd "
        .. table.concat(events, ",")
        .. " <buffer> ++once lua pcall(vim.api.nvim_win_close, "
        .. winnr
        .. ", true)"
    )
  end
end

function window.create_floating_file(location, opts)
  vim.validate({
    location = { location, "t" },
    opts = { opts, "t", true },
  })

  -- Set some defaults
  opts = opts or {}
  local close_events = opts.close_events or { "CursorMoved", "CursorMovedI", "BufHidden", "InsertCharPre" }

  -- location may be LocationLink or Location
  local uri = location.targetUri or location.uri
  if uri == nil then
    return
  end
  local bufnr = vim.uri_to_bufnr(uri)
  if not vim.api.nvim_buf_is_loaded(bufnr) then
    vim.fn.bufload(bufnr)
  end

  local range = location.targetRange or location.range

  local contents = vim.api.nvim_buf_get_lines(
    bufnr,
    range.start.line,
    math.min(range["end"].line + 1 + (opts.context or 10), range.start.line + (opts.max_height or 15)), -- Don't let the window be more that 15 lines long(height)
    false
  )
  local width, height = vim.lsp.util._make_floating_popup_size(contents, opts)
  opts = vim.lsp.util.make_floating_popup_options(width, height, opts)
  -- Don't make it minimal as it is meant to be fully featured
  opts["style"] = nil

  vim.api.nvim_buf_set_option(bufnr, "bufhidden", "wipe")

  local winnr = vim.api.nvim_open_win(bufnr, false, opts)
  vim.api.nvim_win_set_option(winnr, "winblend", 0)

  vim.api.nvim_buf_set_var(bufnr, "lsp_floating_window", winnr)

  -- Set some autocmds to close the window
  vim.api.nvim_command(
    "autocmd QuitPre <buffer> ++nested ++once lua pcall(vim.api.nvim_win_close, " .. winnr .. ", true)"
  )
  close_preview_autocmd(close_events, winnr)

  return bufnr, winnr
end

return window
