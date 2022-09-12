local LanguageServer = require("lsp.language_server")

local opts = {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        -- version = "LuaJIT",
      },
      diagnostics = {
        -- Get the language server to recognize the global vars
        globals = {},
      },
      workspace = {
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
      enabled = true,
      runtime = true, -- runtime path
      types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
      plugins = true, -- installed opt or start plugins in packpath
      -- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
    },
    override = function(root_dir, options) end,
  })
  opts.settings.Lua.workspace.maxPreload = 100000
  opts.settings.Lua.workspace.preloadFileSize = 100000
elseif require("utils.lsp").get_root_dir() == os.getenv("HOME") .. "/.config/awesome" then
  opts.settings.Lua.runtime.version = "Lua 5.3"
  opts.settings.Lua.diagnostics.globals = { "awesome", "client", "mouse", "root", "screen" }
  opts.settings.Lua.workspace.library = {
    ["/usr/share/awesome/lib"] = true,
  }
end

local ls = LanguageServer:create({
  server_name = "sumneko_lua",
  formatters = "stylua",
  custom = opts,
})

return ls
