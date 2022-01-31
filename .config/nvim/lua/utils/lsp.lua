local M = {}

local map = require("utils.wrappers").map

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

local function save_file(format, force)
  -- Format the file
  if format then
    vim.lsp.buf.formatting_sync()
  end

  -- Save the file
  if force then
    vim.cmd("write!")
  else
    vim.cmd("write")
  end
end

function M.setup_format_on_save(client)
  if client.resolved_capabilities.document_formatting then
    map("n", "<C-s>", function()
      save_file(true)
    end, { buffer = true })
    map("n", "<M-s>", function()
      save_file(false)
    end, { buffer = true })

    map("v", "<C-s>", function()
      save_file(true, true)
    end, { buffer = true })
    map("v", "<M-s>", function()
      save_file(false, true)
    end, { buffer = true })
  end
end

function M.get_root_dir(filename)
  -- Look into this: require('lspconfig/util').root_pattern("files", ".git", ".")
  return vim.fn.getcwd()
end

function M.setup_keybindings(bufnr)
  require("keymappings.lsp").setup(bufnr)
end

function M.setup_inlay_hints()
  require("utils.wrappers").define_augroups({
    lsp_inlay_hints = {
      { "TextChanged,TextChangedI", "<buffer>", "lua require('lsp_extensions').inlay_hints({ prefix = '  ' })" },
    },
  })

  -- TODO: Figure out a way to run this once the server has started
  -- require("lsp_extensions").inlay_hints({ prefix = "  " })
end

function M.setup_codelens()
  require("utils.wrappers").define_augroups({
    lsp_codelens = {
      { "TextChanged,TextChangedI", "<buffer>", "lua vim.lsp.codelens.refresh()" },
    },
  })

  -- TODO: Figure out a way to run this once the server has started
  -- vim.lsp.codelens.refresh()
end

return M
