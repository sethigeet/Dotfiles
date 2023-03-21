return {
  { "MunifTanjim/nui.nvim", lazy = true },

  { "kyazdani42/nvim-web-devicons", lazy = true },

  {
    "rcarriga/nvim-notify",

    opts = {
      -- Animation style
      stages = "slide",
    },

    config = function(_, opts)
      local notify = require("notify")

      notify.setup(opts)

      vim.notify = notify
    end,
  },

  {
    "petertriho/nvim-scrollbar",

    opts = function()
      local colors = require("tokyonight.colors").setup()

      return {
        show = true,
        set_highlights = true,
        handle = {
          text = " ",
          color = colors.bg_highlight,
          cterm = nil,
          highlight = "CursorColumn",
          hide_if_all_visible = true, -- Hides handle if all lines are visible
        },
        marks = {
          Search = {
            text = { "" },
            priority = 0,
            color = colors.orange,
            cterm = nil,
            highlight = "Search",
          },
          Error = {
            text = { "" },
            priority = 1,
            color = colors.error,
            cterm = nil,
            highlight = "DiagnosticVirtualTextError",
          },
          Warn = {
            text = { "" },
            priority = 2,
            color = colors.warning,
            cterm = nil,
            highlight = "DiagnosticVirtualTextWarn",
          },
          Info = {
            text = { "" },
            priority = 3,
            color = colors.info,
            cterm = nil,
            highlight = "DiagnosticVirtualTextInfo",
          },
          Hint = {
            text = { "" },
            priority = 4,
            color = colors.hint,
            cterm = nil,
            highlight = "DiagnosticVirtualTextHint",
          },
          Misc = {
            text = { "" },
            priority = 5,
            color = colors.purple,
            cterm = nil,
            highlight = "Normal",
          },
        },
        excluded_buftypes = {
          "terminal",
        },
        excluded_filetypes = {
          "prompt",
          "TelescopePrompt",
          "alpha",
        },
        autocmd = {
          render = {
            "BufWinEnter",
            "TabEnter",
            "TermEnter",
            "WinEnter",
            "CmdwinLeave",
            "TextChanged",
            "VimResized",
            "WinScrolled",
          },
        },
        handlers = {
          diagnostic = true,
          search = false, -- Handled manually in the `hlslens` plugin config
        },
      }
    end,

    config = function(_, opts)
      require("scrollbar").setup(opts)

      -- Integration with `nvim-hlslens` plugin
      require("scrollbar.handlers.search").setup({
        calm_down = true,
        nearest_only = true,
      })

      -- Integration with `gitsigns.nvim` plugin
      require("scrollbar.handlers.gitsigns").setup()
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",

    utils = {
      get_tab_stop = function()
        local label = "Tab Size: "
        if vim.api.nvim_buf_get_option(0, "expandtab") then label = "Spaces: " end
        return " " .. label .. vim.api.nvim_buf_get_option(0, "shiftwidth")
      end,

      get_lsp_client = function()
        local msg = "  No Active Lsp"
        local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then return msg end

        for _, client in ipairs(clients) do
          local filetypes = client.config.filetypes
          if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 and client.name ~= "null-ls" then
            return "  " .. client.name
          end
        end
        return msg
      end,
    },

    opts = function(self)
      local navic = require("nvim-navic")

      return {
        options = {
          theme = "tokyonight",
          globalstatus = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },
          lualine_c = {
            {
              "diff",
              colored = true,
              symbols = { added = " ", modified = "柳", removed = " " },
            },
            {
              "diagnostics",
              sources = { "nvim_diagnostic" },
              sections = { "error", "warn", "info" },
              symbols = { error = " ", warn = " ", info = " " },
            },
            { "filename", symbols = { modified = "  ", readonly = "  " } },
          },
          lualine_x = { { "filetype", colored = true }, self.utils.get_lsp_client },
          lualine_y = { self.utils.get_tab_stop },
          lualine_z = { "location" },
        },
        winbar = {
          lualine_c = { { navic.get_location, cond = navic.is_available } },
        },
        extensions = { "nvim-tree", "quickfix", "toggleterm", "symbols-outline" },
      }
    end,
  },

  {
    "akinsho/bufferline.nvim",
    dependencies = { { "tiagovla/scope.nvim", config = true } },
    event = "VeryLazy",

    opts = {
      options = {
        mode = "buffers", -- set to "tabs" to only show tabpages instead
        numbers = "none",
        close_command = "Bdelete %d",
        right_mouse_command = "Bdelete! %d",
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(_, _, diagnostics_dict)
          local s = " "
          for e, n in pairs(diagnostics_dict) do
            local sym
            if e == "error" then
              sym = " "
            elseif e == "warning" then
              sym = " "
            elseif e == "info" then
              sym = " "
            else
              sym = " "
            end
            s = s .. n .. sym
          end
          return s
        end,
        offsets = { { filetype = "NvimTree", text = "File Explorer", text_align = "center" } },
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        separator_style = "thin",
      },
    },

    keys = function()
      local maps = {
        -- Goto any buffer instantly
        { "<M-b>", "<Cmd>BufferLinePick<CR>" },

        -- Move between buffers using Tab and Shift + Tab
        { "<TAB>", "<Cmd>BufferLineCycleNext<CR>" },
        { "<S-TAB>", "<Cmd>BufferLineCyclePrev<CR>" },

        -- Move between buffers using Shift + Arrow Keys
        { "<S-Left>", "<Cmd>BufferLineCyclePrev<CR>" },
        { "<S-Right>", "<Cmd>BufferLineCycleNext<CR>" },

        -- Move between buffers using Ctrl + h,l Keys
        { "<C-h>", "<Cmd>BufferLineCyclePrev<CR>" },
        { "<C-l>", "<Cmd>BufferLineCycleNext<CR>" },

        -- Move buffers using Ctrl + Arrow Keys
        { "<C-Left>", "<Cmd>BufferLineMovePrev<CR>" },
        { "<C-Right>", "<Cmd>BufferLineMoveNext<CR>" },

        { "<leader>bh", "<Cmd>BufferLineCloseLeft<CR>", desc = "Close left" },
        { "<leader>bl", "<Cmd>BufferLineCloseRight<CR>", desc = "Close right" },
        { "<leader>bH", "<Cmd>BufferLineMovePrev<CR>", desc = "Move to previous" },
        { "<leader>bL", "<Cmd>BufferLineMoveNext<CR>", desc = "Move to next" },

        { "<leader>bp", "<Cmd>BufferLinePick<CR>", desc = "Pick buffer" },
      }

      -- Move to a buffer using Alt+number
      local goto_buf = require("bufferline").go_to_buffer
      for i = 1, 9, 1 do
        table.insert(maps, {
          string.format("<M-%d>", i),
          function() goto_buf(i) end,
          desc = "Goto buffer " .. i,
        })
      end

      return maps
    end,
  },

  {
    "kyazdani42/nvim-tree.lua",

    keys = {
      { "<leader>?", "<Cmd>NvimTreeFindFile<CR>", desc = "Show file in tree" },
      { "<leader>e", "<Cmd>NvimTreeToggle<CR>", desc = "Show file explorer" },
    },

    opts = {
      -- disables netrw completely
      disable_netrw = true,
      -- hijack the cursor in the tree to put it at the start of the filename
      hijack_cursor = true,
      -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
      update_cwd = true,

      respect_buf_cwd = true,

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
        enable = true,
        ignore_list = { "dashboard", "startify" },
      },
      actions = {
        open_file = {
          resize_window = false,
        },
      },
      renderer = {
        highlight_git = true,
        indent_markers = { enable = true },
        icons = {
          glyphs = {
            default = "",
            symlink = "",
            folder = {
              arrow_closed = "",
              arrow_open = "",
              default = "",
              open = "",
              empty = "",
              empty_open = "",
              symlink = "",
              symlink_open = "",
            },
            git = {
              unstaged = "",
              staged = "✓",
              unmerged = "",
              renamed = "➜",
              untracked = "✗",
              deleted = "",
              ignored = "◌",
            },
          },
        },
      },
      view = {
        mappings = {
          custom_only = false,
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
    },
  },

  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",

    opts = {
      window = {
        width = 0.8,
        options = {
          number = true,
          relativenumber = true,
          cursorline = true,
        },
      },
      plugins = {
        options = {
          enabled = true,
          ruler = false,
          showcmd = false,
        },
        twilight = { enabled = false },
      },
    },
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPost",

    opts = {
      buftype_exclude = { "help", "terminal" },
      bufname_exclude = { "vifm*" },
      filetype_exclude = {
        "vimwiki",
        "NvimTree",
        "help",
        "undotree",
        "diff",
        "git",
        "alpha",
        "neogitstatus",
        "packer",
      },
      char = "▏",
      use_treesitter = true,
      show_trailing_blankline_indent = false,
      space_char_blankline = " ",
      show_current_context = true,
      show_current_context_start = true,
      context_patterns = {
        "class",
        "return",
        "function",
        "method",
        "^if",
        "^while",
        "jsx_element",
        "^for",
        "^object",
        "^table",
        "block",
        "arguments",
        "if_statement",
        "else_clause",
        "jsx_element",
        "jsx_self_closing_element",
        "try_statement",
        "catch_clause",
        "import_statement",
      },
    },
  },

  {
    "goolord/alpha-nvim",
    event = "VimEnter",

    opts = function()
      local dashboard = require("alpha.themes.dashboard")

      -- Header
      dashboard.section.header.val = {
        "                                              ",
        "       ███████████           █████      ██",
        "      ███████████             █████ ",
        "      ████████████████ ███████████ ███   ███████",
        "     ████████████████ ████████████ █████ ██████████████",
        "    █████████████████████████████ █████ █████ ████ █████",
        "  ██████████████████████████████████ █████ █████ ████ █████",
        " ██████  ███ █████████████████ ████ █████ █████ ████ ██████",
        " ██████   ██  ███████████████   ██ █████████████████",
        " ██████   ██  ███████████████   ██ █████████████████ ",
      }

      -- Buttons
      dashboard.section.buttons.val = {
        dashboard.button("f", " Find File", ":Telescope find_files<CR>"),
        dashboard.button("r", " Recently Used Files", ":Telescope oldfiles<CR>"),
        dashboard.button("w", " Find Word", ":Telescope live_grep<CR>"),
        dashboard.button("m", " Marks", ":Telescope marks<CR>"),
        dashboard.button("c", " Nvim Config", "cd " .. CONFIG_PATH .. " | edit $MYVIMRC"),
        dashboard.button("p", " Projects", ":Telescope projects<CR>"),
      }

      for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = "AlphaButtons"
        button.opts.hl_shortcut = "AlphaShortcut"
      end
      dashboard.section.footer.opts.hl = "Type"
      dashboard.section.header.opts.hl = "AlphaHeader"
      dashboard.section.buttons.opts.hl = "AlphaButtons"
      dashboard.opts.layout[1].val = 8

      dashboard.section.footer.val = "by Geet Sethi (sethigeet)"

      return dashboard
    end,

    config = function(_, dashboard) require("alpha").setup(dashboard.opts) end,
  },
}
