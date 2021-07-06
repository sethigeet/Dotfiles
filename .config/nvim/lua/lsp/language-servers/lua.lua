require("lspconfig").lua.setup({
  root_dir = require("lsp.helpers.root_dir"),
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Setup your lua path
        path = vim.split(package.path, ";"),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim", "xplr" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
        },
      },
    },
  },
  on_attach = function(client, bufnr)
    require("lsp.helpers.document_highlight")(client)
    require("lsp.helpers.auto_format")("lua", client)
  end,
  handlers = {
    ["textDocument/publishDiagnostics"] = require("lsp.helpers.diagnostics_handler")("lua"),
  },
})
