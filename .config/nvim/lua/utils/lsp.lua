local M = {}

local map = require("utils.map")

function M.check_lsp_client_active(name)
  local active_clients = vim.lsp.get_active_clients()
  -- Check if a particular client is active
  if name then
    for _, client in pairs(active_clients) do
      if client.name == name then
        return true
      end
    end
    return false
  end

  -- Just check if any client is active
  if next(active_clients) == nil then
    return false
  end
  return true
end

function M.setup_document_highlight(client)
  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=#464646
      hi LspReferenceText cterm=bold ctermbg=red guibg=#464646
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=#464646
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
      false
    )
  end
end

function M.setup_format_on_save(client)
  if client.resolved_capabilities.document_formatting then
    map.nnoremap("<C-s>", "<cmd>lua SaveFile(true)<CR>", { buffer = true })
    map.nnoremap("<M-s>", "<cmd>lua SaveFile(false)<CR>", { buffer = true })

    map.vnoremap("<C-s>", "<cmd>lua SaveFile(true, true)<CR>", { buffer = true })
    map.vnoremap("<M-s>", "<cmd>lua SaveFile(false, true)<CR>", { buffer = true })
  end
end

function M.get_root_dir(filename)
  -- Look into this: require('lspconfig/util').root_pattern("files", ".git", ".")
  return vim.fn.getcwd()
end

return M
