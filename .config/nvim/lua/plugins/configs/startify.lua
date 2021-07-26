local plugin = {}

function plugin.setup()
  vim.g.startify_custom_header = {
    [[       ______          __ _          _   ___    ________  ___]],
    [[      / ____/__  ___  / /( )_____   / | / / |  / /  _/  |/  /]],
    [[     / / __/ _ \/ _ \/ __/// ___/  /  |/ /| | / // // /|_/ / ]],
    [[    / /_/ /  __/  __/ /_  (__  )  / /|  / | |/ // // /  / /  ]],
    [[    \____/\___/\___/\__/ /____/  /_/ |_/  |___/___/_/  /_/   ]],
  }
  vim.g.startify_session_dir = "~/.config/nvim/session"
  vim.g.startify_lists = {
    { type = "files", header = { "   Files" } },
    { type = "dir", header = { "   Current Directory " .. vim.fn.getcwd() } },
    { type = "sessions", header = { "   Sessions" } },
    { type = "bookmarks", header = { "   Bookmarks" } },
  }
  vim.g.startify_session_autoload = true
  vim.g.startify_session_delete_buffers = true
  vim.g.startify_change_to_vcs_root = true
  vim.g.startify_fortune_use_unicode = true
  vim.g.startify_session_persistence = true
  vim.g.webdevicons_enable_startify = true
  vim.g.startify_bookmarks = {
    { i = "~/.config/nvim/init.lua" },
    { z = "~/.zshrc" },
    { a = "~/.config/shell/aliases" },
    { p = "~/.config/shell/paths" },
    { c = "~/.config/shell/conda_init" },
    { v = "~/.config/shell/var_exports" },
  }
  vim.g.startify_enable_special = true

  vim.cmd([[
function! StartifyEntryFormat()
        return 'WebDevIconsGetFileTypeSymbol(absolute_path) ." ". entry_path'
endfunction
]])
end

return plugin
