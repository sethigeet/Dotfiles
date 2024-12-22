return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    init = function()
      -- Notification commands
      vim.api.nvim_create_user_command(
        "NotificationHistory",
        function() Snacks.notifier.show_history() end,
        { desc = "Show the notification history" }
      )
      vim.api.nvim_create_user_command(
        "NotificationHide",
        function() Snacks.notifier.hide() end,
        { desc = "Hide all the notifications" }
      )

      -- Terminal commands
      vim.api.nvim_create_user_command(
        "TerminalToggle",
        function() Snacks.terminal.toggle() end,
        { desc = "Toggle the terminal" }
      )
      vim.keymap.set({ "n", "t" }, "<C-`>", "<cmd>TerminalToggle<CR>")
    end,
    opts = {
      bufdelete = { enabled = true },
      animate = { enabled = true },
      dashboard = {
        enabled = true,
        sections = {
          { section = "header" },
          {
            pane = 2,
            section = "terminal",
            cmd = "colorscript -e square",
            height = 5,
            padding = 1,
          },
          { section = "keys", gap = 1, padding = 1 },
          { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
          {
            pane = 2,
            icon = " ",
            title = "Git Status",
            section = "terminal",
            enabled = function() return Snacks.git.get_root() ~= nil end,
            cmd = "git status --short --branch --renames",
            height = 5,
            padding = 1,
            ttl = 5 * 60,
            indent = 3,
          },
          { section = "startup" },
        },
      },
      indent = { enabled = true },
      input = { enabled = true },
      notify = { enabled = true },
      notifier = { enabled = true },
      scope = {
        enabled = true,
        keys = {},
      },
      scroll = {
        enabled = true,
        animate = {
          duration = { step = 15, total = 150 },
          easing = "linear",
        },
      },
      statuscolumn = {
        left = { "mark", "sign" }, -- priority of signs on the left (high to low)
        right = { "fold", "git" }, -- priority of signs on the right (high to low)
        folds = {
          open = true, -- show open fold icons
          git_hl = false, -- use Git Signs hl for fold icons
        },
        git = {
          -- patterns to match Git signs
          patterns = { "GitSign" },
        },
        refresh = 50, -- refresh at most every 50ms
      },
      terminal = { enabled = true },
    },
    -- keys = function()
    --   return {
    --     { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete buffer" },
    --     { "X",          function() Snacks.bufdelete() end, desc = "Delete buffer" },
    --
    --     { "<C-`>",      function() Snacks.terminal.toggle() end, desc = "Toggle terminal" },
    --   }
    -- end
  },
}
