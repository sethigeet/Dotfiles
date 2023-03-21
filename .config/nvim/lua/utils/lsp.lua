local M = {}

local map = require("utils.wrappers").map

function M.check_lsp_client_active(name)
  local active_clients = vim.lsp.get_active_clients()
  -- Check if a particular client is active
  if name then
    for _, client in pairs(active_clients) do
      if client.name == name then return true end
    end
    return false
  end

  -- Just check if any client is active
  if next(active_clients) == nil then return false end
  return true
end

function M.setup_document_highlight(client)
  -- Set autocommands conditional on server_capabilities
  if client.supports_method("textDocument/documentHighlight") then
    local wrappers = require("utils.wrappers")

    wrappers.define_augroups({
      lsp_document_highlight = {
        { "CursorHold", "<buffer>", cb = vim.lsp.buf.document_highlight },
        { "CursorMoved", "<buffer>", cb = vim.lsp.buf.clear_references },
      },
    })

    wrappers.highlight_groups({
      LspReferenceRead = { ctermbg = "red", bg = "#464646" },
      LspReferenceText = { ctermbg = "red", bg = "#464646" },
      LspReferenceWrite = { ctermbg = "red", bg = "#464646" },
    })
  end
end

local function save_file(format, force)
  -- Format the file
  if format then vim.lsp.buf.format() end

  -- Save the file
  if force then
    vim.cmd("write!")
  else
    vim.cmd("write")
  end
end

function M.setup_format_on_save(client)
  if client.supports_method("textDocument/formatting") then
    map("n", "<C-s>", function() save_file(true) end, { buffer = true })
    map("n", "<M-s>", function() save_file(false) end, { buffer = true })

    map("v", "<C-s>", function() save_file(true, true) end, { buffer = true })
    map("v", "<M-s>", function() save_file(false, true) end, { buffer = true })
  end
end

function M.get_root_dir(filename)
  -- Look into this: require('lspconfig/util').root_pattern("files", ".git", ".")
  return vim.fn.getcwd()
end

function M.setup_keybindings(bufnr) require("keymappings.lsp").setup(bufnr) end

function M.setup_inlay_hints()
  require("utils.wrappers").define_augroups({
    lsp_inlay_hints = {
      {
        "TextChanged,TextChangedI",
        "<buffer>",
        cb = function() require("lsp_extensions").inlay_hints({ prefix = "  " }) end,
      },
    },
  })

  -- TODO: Figure out a way to run this once the server has started
  -- require("lsp_extensions").inlay_hints({ prefix = "  " })
end

function M.setup_codelens()
  require("utils.wrappers").define_augroups({
    lsp_codelens = {
      { "TextChanged,TextChangedI", "<buffer>", cb = vim.lsp.codelens.refresh },
    },
  })

  -- TODO: Figure out a way to run this once the server has started
  -- vim.lsp.codelens.refresh()
end

function M.setup_dim_unused()
  -- TODO: Figure out why is this not working?
  -- require("lsp.helpers.dim_unused").setup()
end

return M
