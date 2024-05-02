return {
  bootstrap_plugin_manager = function()
    local lazypath = DATA_PATH .. "/lazy/lazy.nvim"
    if not vim.loop.fs_stat(lazypath) then
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

    require("lazy").setup("plugins")
    require("utils.wrappers").map("n", "<leader>P", "<Cmd>Lazy<CR>", { desc = "Open plugins manager" })
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
  { "mg979/vim-visual-multi", event = "BufRead" },

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
    "tpope/vim-surround",
    event = "BufRead",
  },

  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = { { "tpope/vim-dadbod", cmd = "DB" } },
    cmd = { "DBUI", "DBUIToggle" },

    config = function()
      vim.g.db_ui_save_location = DATA_PATH .. "/dadbod.db"
      vim.g.db_ui_auto_execute_table_helpers = true
    end,

    keys = {
      { "<leader>Dt", "<Cmd>DBUIToggle<CR>", desc = "Toggle UI" },
      { "<leader>Df", "<Cmd>DBUIFindBuffer<CR>", desc = "Find buffer" },
      { "<leader>Dr", "<Cmd>DBUIRenameBuffer<CR>", desc = "Rename buffer" },
      { "<leader>Di", "<Cmd>DBUILastQueryInfo<CR>", desc = "Last query info" },
    },
  },

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

  -- TODO: Migrate the configs of these plugins
  -- Terminal
  -- {
  --   "akinsho/toggleterm.nvim",
  --   keys = { "`", "<F1>", "<leader>T" },
  --   module = { "toggleterm", "toggleterm.terminal" },
  --   config = "toggleterm",
  -- },
}
