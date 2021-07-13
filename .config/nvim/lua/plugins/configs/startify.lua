local plugin = {}

function plugin.setup()
  vim.g.startify_custom_header = Opts.plugin.startify.config.custom_header
  vim.g.startify_session_dir = Opts.plugin.startify.config.session_dir
  vim.g.startify_lists = Opts.plugin.startify.config.startify_lists
  vim.g.startify_session_autoload = Opts.plugin.startify.config.session_autoload
  vim.g.startify_session_delete_buffers = Opts.plugin.startify.config.session_delete_buffers
  vim.g.startify_change_to_vcs_root = Opts.plugin.startify.config.change_to_vcs_root
  vim.g.startify_fortune_use_unicode = Opts.plugin.startify.config.fortune_use_unicode
  vim.g.startify_session_persistence = Opts.plugin.startify.config.session_persistence
  vim.g.webdevicons_enable_startify = Opts.plugin.startify.config.enable_webdevicons
  vim.g.startify_bookmarks = Opts.plugin.startify.config.bookmarks
  vim.g.startify_enable_special = Opts.plugin.startify.config.enable_special

  vim.cmd([[
function! StartifyEntryFormat()
        return 'WebDevIconsGetFileTypeSymbol(absolute_path) ." ". entry_path'
endfunction
]])
end

function plugin.config()
  Opts.plugin["startify"] = {
    enabled = true,
    config = {
      custom_header = {
        [[       ______          __ _          _   ___    ________  ___]],
        [[      / ____/__  ___  / /( )_____   / | / / |  / /  _/  |/  /]],
        [[     / / __/ _ \/ _ \/ __/// ___/  /  |/ /| | / // // /|_/ / ]],
        [[    / /_/ /  __/  __/ /_  (__  )  / /|  / | |/ // // /  / /  ]],
        [[    \____/\___/\___/\__/ /____/  /_/ |_/  |___/___/_/  /_/   ]],
      },

      session_dir = "~/.config/nvim/session",

      lists = {
        { type = "files", header = { "   Files" } },
        { type = "dir", header = { "   Current Directory " .. vim.fn.getcwd() } },
        { type = "sessions", header = { "   Sessions" } },
        { type = "bookmarks", header = { "   Bookmarks" } },
      },

      session_autoload = 1,
      session_delete_buffers = 1,
      change_to_vcs_root = 1,
      fortune_use_unicode = 1,
      session_persistence = 1,

      enable_webdevicons = 1,

      bookmarks = {
        { i = "~/.config/nvim/init.lua" },
        { z = "~/.zshrc" },
        { a = "~/.config/shell/aliases" },
        { p = "~/.config/shell/paths" },
        { c = "~/.config/shell/conda_init" },
        { v = "~/.config/shell/var_exports" },
      },

      enable_special = 0,
    },
  }
end

return plugin
