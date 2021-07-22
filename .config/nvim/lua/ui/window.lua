local M = {}

function M.create_floating_window(contents, filetype, opts)
  vim.validate({
    contents = { contents, "t" },
    filetype = { filetype, "s", true },
    opts = { opts, "t", true },
  })

  local enter = opts.enter == true

  local bufnr = vim.api.nvim_create_buf(false, true)

  -- Clean up input: trim empty lines from the end, pad
  local cleaned_content = vim.lsp.util._trim(contents)

  if filetype then
    vim.api.nvim_buf_set_option(bufnr, "filetype", filetype)
  end

  opts = opts or {}
  local width, height = vim.lsp.util._make_floating_popup_size(contents, opts)
  opts = vim.lsp.util.make_floating_popup_options(width, height, opts)

  vim.api.nvim_buf_set_lines(bufnr, 0, -1, true, cleaned_content)
  vim.api.nvim_buf_set_option(bufnr, "modifiable", false)
  vim.api.nvim_buf_set_option(bufnr, "bufhidden", "wipe")

  local winnr = vim.api.nvim_open_win(bufnr, enter, opts)
  vim.api.nvim_win_set_option(winnr, "winblend", 0)
  vim.api.nvim_win_set_option(winnr, "foldenable", false)

  vim.api.nvim_buf_set_var(bufnr, "lsp_floating_preview", winnr)
  vim.api.nvim_command(
    "autocmd QuitPre <buffer> ++nested ++once lua pcall(vim.api.nvim_win_close, " .. winnr .. ", true)"
  )

  return bufnr, winnr
end

return M
