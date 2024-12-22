return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    init = function()
      -- Buffer delete commands
      vim.api.nvim_create_user_command(
        "BufDelete",
        function(opts) Snacks.bufdelete.delete({ force = opts.bang }) end,
        { desc = "Delete the current buffer", bang = true }
      )
      vim.keymap.set("n", "<leader>bd", function() Snacks.bufdelete() end, { desc = "Delete the current buffer" })
      vim.keymap.set("n", "X", function() Snacks.bufdelete() end, { desc = "Delete the current buffer" })

      -- Lazygit commands
      vim.api.nvim_create_user_command("Lazygit", function() Snacks.lazygit.open() end, { desc = "Open lazygit" })
      vim.keymap.set("n", "<leader>gl", function() Snacks.lazygit.open() end, { desc = "Open lazygit" })

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

      -- Scratch buffer commands
      vim.api.nvim_create_user_command(
        "ScratchToggle",
        function() Snacks.scratch() end,
        { desc = "Toggle the scratch buffer" }
      )
      vim.api.nvim_create_user_command(
        "ScratchSelect",
        function() Snacks.scratch.select() end,
        { desc = "Select a scratch buffer" }
      )
      vim.keymap.set("n", "<leader>.", function() Snacks.scratch() end)

      -- Terminal commands
      vim.api.nvim_create_user_command(
        "TerminalNew",
        function() Snacks.terminal.open() end,
        { desc = "Open a new terminal" }
      )
      vim.api.nvim_create_user_command(
        "TerminalToggle",
        function() Snacks.terminal.toggle() end,
        { desc = "Toggle the terminal" }
      )
      vim.keymap.set({ "n", "t" }, "<C-`>", "<cmd>TerminalToggle<CR>", { desc = "Toggle the terminal" })

      -- Keybinds to move between references (words plugin)
      vim.keymap.set({ "n", "x" }, "[r", function() Snacks.words.jump(1, true) end, { desc = "Goto prev reference" })
      vim.keymap.set({ "n", "x" }, "]r", function() Snacks.words.jump(1, true) end, { desc = "Goto next reference" })
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
      scratch = { enabled = true },
      scroll = {
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
      words = {
        debounce = 200, -- time in ms to wait before updating
        notify_jump = false, -- show a notification when jumping
        notify_end = false, -- show a notification when reaching the end
        foldopen = true, -- open folds after jumping
        jumplist = true, -- set jump point before jumping
        modes = { "n", "i", "c" }, -- modes to show references
      },
    },
  },
}
