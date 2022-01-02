local LanguageServer = require("lsp.language_server")

local opts = {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
      },
      diagnostics = {
        -- Get the language server to recognize the global vars
        globals = { "xplr" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {},
        maxPreload = 100000,
        preloadFileSize = 100000,
      },
      telemetry = { enable = false },
    },
  },
}

if require("utils.lsp").get_root_dir() == os.getenv("HOME") .. "/.config/nvim" then
  opts = require("lua-dev").setup({
    library = {
      vimruntime = true, -- runtime path
      types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
      plugins = true, -- installed opt or start plugins in packpath
    },
    runtime_path = false, -- enable this to get completion in require strings. Slow!
    -- pass any additional options that will be merged in the final lsp config
    lspconfig = opts,
  })
end

local ls = LanguageServer:create({
  server_name = "sumneko_lua",
  formatters = "stylua",
  custom = opts,
})

return ls
