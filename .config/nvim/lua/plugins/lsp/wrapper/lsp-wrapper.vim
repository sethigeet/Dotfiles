command! LspCodeAction lua require 'plugins.lsp.wrapper.lsp-wrapper'.code_action()
command! LspDeclaration lua require 'plugins.lsp.wrapper.lsp-wrapper'.declaration()
command! LspDefinition lua require 'plugins.lsp.wrapper.lsp-wrapper'.definition()
command! LspDocumentSymbol lua require 'plugins.lsp.wrapper.lsp-wrapper'.document_symbol()
command! LspFormatting lua require 'plugins.lsp.wrapper.lsp-wrapper'.formatting()
command! LspFormattingSync lua require 'plugins.lsp.wrapper.lsp-wrapper'.formatting_sync()
command! LspHover lua require 'plugins.lsp.wrapper.lsp-wrapper'.hover()
command! LspImplementation lua require 'plugins.lsp.wrapper.lsp-wrapper'.implementation()
command! LspRangeCodeAction lua require 'plugins.lsp.wrapper.lsp-wrapper'.range_code_action()
command! LspRangeFormatting lua require 'plugins.lsp.wrapper.lsp-wrapper'.range_formatting()
command! LspReferences lua require 'plugins.lsp.wrapper.lsp-wrapper'.references()
command! LspRename lua require 'plugins.lsp.wrapper.lsp-wrapper'.rename()
command! LspTypeDefinition lua require 'plugins.lsp.wrapper.lsp-wrapper'.type_definition()
command! LspWorkspaceSymbol lua require 'plugins.lsp.wrapper.lsp-wrapper'.workspace_symbol()
command! LspGotoNext lua require 'plugins.lsp.wrapper.lsp-wrapper'.goto_next()
command! LspGotoPrev lua require 'plugins.lsp.wrapper.lsp-wrapper'.goto_prev()
command! LspShowLineDiagnostics lua require 'plugins.lsp.wrapper.lsp-wrapper'.show_line_diagnostics()
command! LspAddToWorkspaceFolder lua require 'plugins.lsp.wrapper.lsp-wrapper'.add_to_workspace_folder()
command! LspRemoveWorkspaceFolder lua require 'plugins.lsp.wrapper.lsp-wrapper'.remove_workspace_folder()
command! LspListWorkspaceFolders lua require 'plugins.lsp.wrapper.lsp-wrapper'.list_workspace_folders()
command! LspClearReferences lua require 'plugins.lsp.wrapper.lsp-wrapper'.clear_references()
command! LspGetNext lua require 'plugins.lsp.wrapper.lsp-wrapper'.get_next()
command! LspGetPrev lua require 'plugins.lsp.wrapper.lsp-wrapper'.get_prev()
command! LspGetAll lua require 'plugins.lsp.wrapper.lsp-wrapper'.get_all()
command! LspIncomingCalls lua require 'plugins.lsp.wrapper.lsp-wrapper'.incoming_calls()
command! LspOutGoingCalls lua require 'plugins.lsp.wrapper.lsp-wrapper'.outgoing_calls()
command! LspDocumentHighlight lua require 'plugins.lsp.wrapper.lsp-wrapper'.document_highlight()
command! LspPopulateLocationList lua require 'plugins.lsp.wrapper.lsp-wrapper'.populate_location_list()
command! NextHunk lua require 'plugins.lsp.wrapper.lsp-wrapper'.next_hunk()
command! PrevHunk lua require 'plugins.lsp.wrapper.lsp-wrapper'.prev_hunk()
command! StageHunk lua require 'plugins.lsp.wrapper.lsp-wrapper'.stage_hunk()
command! UndoStageHunk lua require 'plugins.lsp.wrapper.lsp-wrapper'.undo_stage_hunk()
command! ResetHunk lua require 'plugins.lsp.wrapper.lsp-wrapper'.reset_hunk()
command! ResetBuffer lua require 'plugins.lsp.wrapper.lsp-wrapper'.reset_buffer()
command! PreviewHunk lua require 'plugins.lsp.wrapper.lsp-wrapper'.preview_hunk()
command! BlameLine lua require 'plugins.lsp.wrapper.lsp-wrapper'.blame_line()
command! -nargs=0 LspVirtualTextToggle lua require 'plugins.lsp.wrapper.lsp-wrapper'.toggle_virtual_text()
