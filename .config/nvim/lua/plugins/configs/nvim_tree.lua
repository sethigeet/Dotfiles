local Plugin = require("plugins.plugin")

return Plugin:create({
  configure = function()
    vim.g.nvim_tree_git_hl = 1 -- 0 by default, will enable file highlight for git attributes (can be used without the icons).
    vim.g.nvim_tree_respect_buf_cwd = 1 -- 0 by default, will change cwd of nvim-tree to that of new buffer's when opening nvim-tree.
    vim.g.nvim_tree_show_icons = { git = 1, folders = 1, files = 1 }

    -- default will show icon by default if no icon is provided
    -- default shows no icon by default
    vim.g.nvim_tree_icons = {
      default = "",
      symlink = "",
      git = { unstaged = "", staged = "✓", unmerged = "", renamed = "➜", untracked = "✗" },
      folder = { default = "", open = "", empty = "", empty_open = "", symlink = "" },
    }

    require("nvim-tree").setup({
      -- disables netrw completely
      disable_netrw = true,
      -- will not open on setup if the filetype is in this list
      ignore_ft_on_setup = { "dashboard", "startify" },
      -- hijack the cursor in the tree to put it at the start of the filename
      hijack_cursor = true,
      -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
      update_cwd = true,

      git = {
        ignore = { ".git", "node_modules", ".cache" }, -- empty by default
      },
      -- show lsp diagnostics in the signcolumn
      diagnostics = {
        enable = true,
        icons = {
          hint = "",
          info = "",
          warning = "",
          error = "",
        },
      },
      -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
      update_focused_file = {
        -- enables the feature
        enable = true,
        -- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
        -- only relevant when `update_focused_file.enable` is true
        update_cwd = true,
        -- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
        -- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
        ignore_list = { "dashboard", "startify" },
      },
      -- configuration options for the system open command (`s` in the tree by default)
      system_open = {
        -- the command to run this, leaving nil should work in most cases
        cmd = nil,
        -- the command arguments as a list
        args = {},
      },
      actions = {
        open_file = {
          quit_on_open = false,
          resize_window = false,
          window_picker = {
            enable = true,
            chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
            exclude = {
              filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
              buftype = { "nofile", "terminal", "help" },
            },
          },
        },
      },
      renderer = {
        indent_markers = {
          enable = true,
          icons = {
            corner = "└ ",
            edge = "│ ",
            none = "  ",
          },
        },
      },
      view = {
        -- width of the window, can be either a number (columns) or a string in `%`
        width = 30,
        -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
        side = "left",
        -- if true the tree will resize itself after opening a file
        auto_resize = false,
        mappings = {
          -- custom only false will merge the list with the default mappings
          -- if true, it will only use your list to set the mappings
          custom_only = false,
          -- list of mappings to set on the tree manually
          list = {
            { key = { "<CR>", "o", "l", "<2-LeftMouse>" }, action = "edit" },
            { key = { "<2-RightMouse>", "<C-]>" }, action = "cd" },
            { key = { "<C-v>", "v" }, action = "vsplit" },
            { key = { "<C-x>", "s" }, action = "split" },
            { key = "<C-t>", action = "tabnew" },
            { key = "<", action = "prev_sibling" },
            { key = ">", action = "next_sibling" },
            { key = "P", action = "parent_node" },
            { key = { "<BS>", "<S-CR>", "h" }, action = "close_node" },
            { key = "<Tab>", action = "preview" },
            { key = "K", action = "first_sibling" },
            { key = "J", action = "last_sibling" },
            { key = "I", action = "toggle_ignored" },
            { key = "H", action = "toggle_dotfiles" },
            { key = "R", action = "refresh" },
            { key = "a", action = "create" },
            { key = "d", action = "remove" },
            { key = "r", action = "rename" },
            { key = "<C-r>", action = "full_rename" },
            { key = "x", action = "cut" },
            { key = "c", action = "copy" },
            { key = "p", action = "paste" },
            { key = "y", action = "copy_name" },
            { key = "Y", action = "copy_path" },
            { key = "gy", action = "copy_absolute_path" },
            { key = "[c", action = "prev_git_item" },
            { key = "}c", action = "next_git_item" },
            { key = "-", action = "dir_up" },
            { key = "q", action = "close" },
            { key = "g?", action = "toggle_help" },
          },
        },
      },
    })
  end,
})
