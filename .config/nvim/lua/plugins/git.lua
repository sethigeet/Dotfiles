return {
  {
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
      "DiffviewRefresh",
    },
    config = true,
  },

  {
    "rhysd/git-messenger.vim",
    event = "BufRead",
    config = function(_, _) vim.g.git_messenger_no_default_mappings = 1 end,
    keys = {
      { "<leader>gm", "<Cmd>GitMessenger<CR>", desc = "Show message" },
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    opts = {
      signs = {
        -- stylua: ignore
        add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
        change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
        delete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
        topdelete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
        changedelete = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
      },
    },
    keys = {
      { "<leader>gD", "<Cmd>Gitsigns preview_hunk<CR>", desc = "Show inline diff" },
      { "<leader>grb", "<Cmd>Gitsigns reset_buffer<CR>", desc = "Reset buffer" },
      { "<leader>grh", "<Cmd>Gitsigns reset_hunk<CR>", desc = "Reset hunk" },
      { "<leader>gsb", "<Cmd>Gitsigns stage_buffer<CR>", desc = "Stage buffer" },
      { "<leader>gsh", "<Cmd>Gitsigns stage_hunk<CR>", desc = "Stage hunk" },
      { "<leader>gsu", "<Cmd>Gitsigns undo_stage_hunk<CR>", desc = "Unstage hunk" },
      { "<leader>gt", "<Cmd>Gitsigns toggle_signs<CR>", desc = "Toggle signs" },
      { "[g", "<Cmd>Gitsigns prev_hunk<CR>", desc = "Goto prev hunk" },
      { "]g", "<Cmd>Gitsigns next_hunk<CR>", desc = "Goto next hunk" },
    },
  },

  {
    "TimUntersberger/neogit",
    cmd = "Neogit",
    opts = {
      -- customize displayed signs
      signs = {
        -- { CLOSED, OPENED }
        section = { "", "" },
        item = { "", "" },
        hunk = { "", "" },
      },
      integrations = {
        diffview = true,
      },
    },
    keys = {
      { "<leader>gg", "<Cmd>Neogit<CR>", desc = "Open neogit" },
      { "<leader>gc", "<Cmd>Neogit commit<CR>", desc = "Commit" },
    },
  },
}
