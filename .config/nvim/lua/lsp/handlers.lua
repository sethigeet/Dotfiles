-- Custom handler overrides
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

local namespaces = vim.lsp.codelens.__namespaces

--- Display the lenses using virtual text
function vim.lsp.codelens.display(lenses, bufnr, client_id)
  if not lenses or not next(lenses) then return end

  local lenses_by_lnum = {}
  for _, lens in pairs(lenses) do
    local line_lenses = lenses_by_lnum[lens.range.start.line]
    if not line_lenses then
      line_lenses = {}
      lenses_by_lnum[lens.range.start.line] = line_lenses
    end
    table.insert(line_lenses, lens)
  end

  local ns = namespaces[client_id]
  vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

  local num_lines = vim.api.nvim_buf_line_count(bufnr)
  for i = 0, num_lines do
    local line_lenses = lenses_by_lnum[i] or {}
    local chunks = {}
    local num_line_lenses = #line_lenses
    for j, lens in ipairs(line_lenses) do
      local text = lens.command and lens.command.title or "Unresolved lens ..."
      table.insert(chunks, { text, "LspCodeLens" })
      if j < num_line_lenses then table.insert(chunks, { " | ", "LspCodeLensSeparator" }) end
    end

    if #chunks > 0 then
      local line = vim.api.nvim_buf_get_lines(bufnr, i, i + 1, false)[1]
      local matched = string.match(line, [[^%s+%w]])
      if matched ~= nil then chunks[1][1] = string.rep(" ", #matched - 1) .. chunks[1][1] end

      vim.api.nvim_buf_set_extmark(bufnr, ns, i, 0, {
        virt_lines = { chunks },
        virt_lines_above = true,
        hl_mode = "combine",
      })
    end
  end
end
