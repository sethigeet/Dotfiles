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
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    init = function()
      require("utils.wrappers").highlight_groups({
        GitSignsAdd = { link = "GitSignsAdd" },
        GitSignsAddLn = { link = "GitSignsAddLn" },
        GitSignsAddNr = { link = "GitSignsAddNr" },
        GitSignsChange = { link = "GitSignsChange" },
        GitSignsChangeLn = { link = "GitSignsChangeLn" },
        GitSignsChangeNr = { link = "GitSignsChangeNr" },
        GitSignsChangedelete = { link = "GitSignsChange" },
        GitSignsChangedeleteLn = { link = "GitSignsChangeLn" },
        GitSignsChangedeleteNr = { link = "GitSignsChangeNr" },
        GitSignsDelete = { link = "GitSignsDelete" },
        GitSignsDeleteLn = { link = "GitSignsDeleteLn" },
        GitSignsDeleteNr = { link = "GitSignsDeleteNr" },
        GitSignsTopdelete = { link = "GitSignsDelete" },
        GitSignsTopdeleteLn = { link = "GitSignsDeleteLn" },
        GitSignsTopdeleteNr = { link = "GitSignsDeleteNr" },
      })
    end,
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "契" },
        topdelete = { text = "契" },
        changedelete = { text = "▎" },
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
