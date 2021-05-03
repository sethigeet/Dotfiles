local lsp_wrapper = {}

-- buffer
function lsp_wrapper.add_to_workspace_folder()
    vim.lsp.buf.add_workspace_folder()
end

function lsp_wrapper.clear_references()
    vim.lsp.buf.clear_references()
end

function lsp_wrapper.code_action()
    vim.lsp.buf.code_action()
end

function lsp_wrapper.declaration()
    vim.lsp.buf.declaration()
    vim.lsp.buf.clear_references()
end

function lsp_wrapper.definition()
    vim.lsp.buf.definition()
    vim.lsp.buf.clear_references()
end

function lsp_wrapper.document_highlight()
    vim.lsp.buf.document_highlight()
end

function lsp_wrapper.document_symbol()
    vim.lsp.buf.document_symbol()
end

function lsp_wrapper.formatting()
    vim.lsp.buf.formatting()
end

function lsp_wrapper.formatting_sync()
    vim.lsp.buf.formatting_sync()
end

function lsp_wrapper.hover()
    vim.lsp.buf.hover()
end

function lsp_wrapper.implementation()
    vim.lsp.buf.implementation()
end

function lsp_wrapper.incoming_calls()
    vim.lsp.buf.incoming_calls()
end

function lsp_wrapper.list_workspace_folders()
    vim.lsp.buf.list_workspace_folders()
end

function lsp_wrapper.outgoing_calls()
    vim.lsp.buf.outgoing_calls()
end

function lsp_wrapper.range_code_action()
    vim.lsp.buf.range_code_action()
end

function lsp_wrapper.range_formatting()
    vim.lsp.buf.range_formatting()
end

function lsp_wrapper.references()
    vim.lsp.buf.references()
    vim.lsp.buf.clear_references()
end

function lsp_wrapper.remove_workspace_folder()
    vim.lsp.buf.remove_workspace_folder()
end

function lsp_wrapper.rename()
    vim.lsp.buf.rename()
end

function lsp_wrapper.signature_help()
    vim.lsp.buf.signature_help()
end

function lsp_wrapper.type_definition()
    vim.lsp.buf.type_definition()
end

function lsp_wrapper.workspace_symbol()
    vim.lsp.buf.workspace_symbol()
end

-- diagnostic
function lsp_wrapper.get_all()
    vim.lsp.diagnostic.get_all()
end

function lsp_wrapper.get_next()
    vim.lsp.diagnostic.get_next()
end

function lsp_wrapper.get_prev()
    vim.lsp.diagnostic.get_prev()
end

function lsp_wrapper.goto_next()
    vim.lsp.diagnostic.goto_next()
end

function lsp_wrapper.goto_prev()
    vim.lsp.diagnostic.goto_prev()
end

function lsp_wrapper.show_line_diagnostics()
    vim.lsp.diagnostic.show_line_diagnostics()
end

function lsp_wrapper.populate_location_list()
    vim.lsp.diagnostic.set_loclist({ open_loclist = false })
end

-- Gitsigns
function lsp_wrapper.next_hunk()
    require("gitsigns").next_hunk()
end

function lsp_wrapper.prev_hunk()
    require("gitsigns").prev_hunk()
end

function lsp_wrapper.stage_hunk()
    require("gitsigns").stage_hunk()
end

function lsp_wrapper.undo_stage_hunk()
    require("gitsigns").undo_stage_hunk()
end

function lsp_wrapper.reset_hunk()
    require("gitsigns").reset_hunk()
end

function lsp_wrapper.reset_buffer()
    require("gitsigns").reset_buffer()
end

function lsp_wrapper.preview_hunk()
    require("gitsigns").preview_hunk()
end

function lsp_wrapper.blame_line()
    require("gitsigns").blame_line()
end

local show_virtual_text = true
function lsp_wrapper.toggle_virtual_text()
    show_virtual_text = not show_virtual_text
    vim.lsp.diagnostic.display(vim.lsp.diagnostic.get(0, 1), 0, 1,
                               { virtual_text = show_virtual_text })
end

-- misc

-- :lua print(vim.inspect(vim.lsp.buf_get_clients()))

-- autoformat
-- autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 1000)

return lsp_wrapper
