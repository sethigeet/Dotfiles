return {
  bootstrap_plugin_manager = function()
    local lazypath = DATA_PATH .. "/lazy/lazy.nvim"
    if not vim.uv.fs_stat(lazypath) then
      vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
      })
    end

    vim.opt.rtp:prepend(lazypath)

    require("lazy").setup({
      rocks = { enabled = false },
      spec = {
        { import = "plugins" },
      },
    })
  end,

  -- Common Utility packages
  { "nvim-lua/plenary.nvim", lazy = true },

  {
    "mbbill/undotree",
    cmd = { "UndotreeShow", "UndotreeToggle" },
    keys = {
      { "<leader>u", "<Cmd>UndotreeToggle<CR>", desc = "Show undo tree" },
    },
  },

  -- Multiple Cursors
  {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    config = true,
    init = function()
      require("utils.wrappers").highlight_groups({
        MultiCursorCursor = { link = "Cursor" },
        MultiCursorVisual = { link = "Visual" },
        MultiCursorSign = { link = "SignColumn" },
        MultiCursorDisabledCursor = { link = "Visual" },
        MultiCursorDisabledVisual = { link = "Visual" },
        MultiCursorDisabledSign = { link = "SignColumn" },
      })
    end,
    keys = function()
      local mc = require("multicursor-nvim")
      return {
        -- Add or skip cursor above/below the main cursor.
        { mode = { "n", "v" }, "<up>", function() mc.lineAddCursor(-1) end, desc = "Add a new cursor above" },
        { mode = { "n", "v" }, "<down>", function() mc.lineAddCursor(1) end, desc = "Add a new cursor below" },

        -- Add a new cursor by matching word/selection
        {
          mode = { "n", "v" },
          "<C-n>",
          function() mc.matchAddCursor(1) end,
          desc = "Add a new cursor to the next match",
        },

        -- Add all matches in the document
        { mode = { "n", "v" }, "<M-n>", mc.matchAllAddCursors, desc = "Add new cursors to all matches" },

        -- Rotate the main cursor.
        { mode = { "n", "v" }, "<Left>", mc.nextCursor, desc = "Move to the next cursor" },
        { mode = { "n", "v" }, "<Right>", mc.prevCursor, desc = "Move to the previous cursor" },

        -- Delete the main cursor.
        { mode = { "n", "v" }, "<localleader>mx", mc.deleteCursor, desc = "Delete the current cursor" },

        -- Add and remove cursors with control + left click.
        { "<C-LeftMouse>", mc.handleMouse, desc = "Add a new cursor at the clicked location" },

        -- Easy way to add and remove cursors using the main cursor.
        { mode = { "n", "v" }, "<localleader>mq", mc.toggleCursor, desc = "Toggle the current cursor" },

        {
          "<esc>",
          function()
            if not mc.cursorsEnabled() then
              mc.enableCursors()
            elseif mc.hasCursors() then
              mc.clearCursors()
            else
              -- Default <esc> handler.
            end
          end,
        },

        -- bring back cursors if you accidentally clear them
        { "<localleader>mv", mc.restoreCursors, desc = "Restore all previous cursors" },

        -- Align cursor columns.
        { "<localleader>ma", mc.alignCursors, desc = "Align all the cursors" },

        -- Append/insert for each line of visual selections.
        { mode = "v", "I", mc.insertVisual, desc = "Add a new insert cursor" },
        { mode = "v", "A", mc.appendVisual, desc = "Add a new append cursor" },

        -- match new cursors within visual selections by regex.
        { mode = "v", "<localleader>mm", mc.matchCursors, desc = "Add new cursors to all matching locations" },
      }
    end,
  },

  -- Debugging
  "mfussenegger/nvim-dap",
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "nvim-neotest/nvim-nio",
    },
  },

  -- Easily change surrounding elements
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {},
  },

  -- {
  --   "kristijanhusak/vim-dadbod-ui",
  --   dependencies = { { "tpope/vim-dadbod", cmd = "DB" } },
  --   cmd = { "DBUI", "DBUIToggle" },
  --
  --   config = function()
  --     vim.g.db_ui_save_location = DATA_PATH .. "/dadbod.db"
  --     vim.g.db_ui_auto_execute_table_helpers = true
  --   end,
  --
  --   keys = {
  --     { "<leader>Dt", "<Cmd>DBUIToggle<CR>", desc = "Toggle UI" },
  --     { "<leader>Df", "<Cmd>DBUIFindBuffer<CR>", desc = "Find buffer" },
  --     { "<leader>Dr", "<Cmd>DBUIRenameBuffer<CR>", desc = "Rename buffer" },
  --     { "<leader>Di", "<Cmd>DBUILastQueryInfo<CR>", desc = "Last query info" },
  --   },
  -- },

  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown", "markdownreact" },
    build = "cd app && npm install",

    config = function()
      vim.g.mkdp_auto_start = false
      vim.g.mkdp_auto_close = true
      vim.g.mkdp_refresh_slow = false
      vim.g.mkdp_command_for_global = false
      vim.g.mkdp_open_to_the_world = false
      vim.g.mkdp_open_ip = ""
      vim.g.mkdp_browser = ""
      vim.g.mkdp_echo_preview_url = true
      vim.g.mkdp_browserfunc = ""
      vim.g.mkdp_preview_options = {
        mkit = {},
        katex = {},
        uml = {},
        maid = {},
        disable_sync_scroll = false,
        sync_scroll_type = "middle",
        hide_yaml_meta = true,
        sequence_diagrams = {},
        flowchart_diagrams = {},
        content_editable = false,
      }
      vim.g.mkdp_markdown_css = ""
      vim.g.mkdp_highlight_css = ""
      vim.g.mkdp_port = "9876"
      vim.g.mkdp_page_title = "${name} - Markdown Preview"
    end,
  },

  {
    "lervag/vimtex",
    ft = "tex",
    init = function()
      vim.g.vimtex_view_method = "zathura"
      vim.g.tex_flavor = "latex"
      vim.g.tex_conceal = "abdmgs"
      vim.g.vimtex_compiler_latexmk_engines = { ["_"] = "-lualatex" }
    end,
  },
}
