CONFIG_PATH = vim.fn.stdpath("config")
DATA_PATH = vim.fn.stdpath("data")
CACHE_PATH = vim.fn.stdpath("cache")

Opts = {
  editor = {
    line_numbers = {
      active = true,
      relative_line_numbers = true,
      -- switch between absolute and relative line numbers depending on mode
      smart_relative_line_numbers = true,
    },
    indent = {
      -- the width of a tab character
      tab_width = 2,
      -- replace tabs with spaces
      expand_tab = true,
    },
    -- wrap lines in the editor instead of scrolling
    wrap = false,

    -- allow the usage of the mouse to scoll and select text
    enable_mouse = true,

    -- the encoding to use for reading and writing to files
    encoding = "utf-8",

    -- highlight the line on which the cursor is present
    ruler = true,

    -- the number of lines to leave below and above the cursor while moving
    scrolloff = {
      -- the number of lines to leave below and above the cursor while moving up and down
      vertical = 4,
      -- the number of lines to leave around the cursor while moving left and right
      horizontal = 4,
    },

    fold_method = "manual",

    -- format the file using an available formatter on saving the file
    format_on_save = true,
  },

  search = {
    -- the default files/folders to ignore while searching
    ignore = { "*.o", "*.a", "__pycache__", "*.pyc", "node_modules" },
  },

  window = {
    colorscheme = "tokyonight",

    -- title of the nvim window
    title = "%F - nvim",
  },

  misc = {
    -- specify the default path for the various interpreters that neovim should use
    exec_paths = {
      -- specify the default path for the python2 interpreter that neovim should use
      python2 = vim.fn.expand("/usr/bin/python2"),
      -- specify the default path for the python3 interpreter that neovim should use
      python3 = vim.fn.expand("/usr/bin/python"),
      -- specify the default path for the node interpreter that neovim should use
      node = vim.fn.expand("/usr/bin/node"),
    },
  },

  -- NOTE: The configuration options for the plugins are set in their own files
  plugin = {},
}

local plugins = {
  "autopairs",
  "bqf",
  "bufferline",
  "codi",
  "colorizer",
  "comment",
  "compe",
  "dadbod",
  "dashboard",
  "dial",
  "emmet",
  "fterm",
  "git_blame",
  "git_messenger",
  "gitsigns",
  "indent_blankline",
  "lsp_signature",
  "lualine",
  "markdown_preview",
  "matchup",
  -- "neogit",
  "neoscroll",
  "numb",
  -- "nvim_tree",
  "rooter",
  "sniprun",
  "spectre",
  -- "startify",
  "surround",
  "symbols_outline",
  "tabular",
  -- "telescope",
  "todo_comments",
  "treesitter",
  "trouble",
  "vifm",
  "vsnip",
  -- "which_key",
  "zen_mode",
}
for _, plugin in ipairs(plugins) do
  require("plugins.configs." .. plugin).config()
end
