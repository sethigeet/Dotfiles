return {
  {
    "numToStr/Comment.nvim",
    event = "BufEnter",

    keys = {
      {
        "<leader>/",
        "<Cmd>lua require('Comment.api').call('toggle_current_linewise_op')<CR>g@$",
        desc = "Comment line",
      },
      {
        mode = "v",
        "<leader>/",
        "<Esc><Cmd>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>",
        desc = "Comment selected region",
      },
    },

    config = function(_, _)
      require("Comment").setup({
        -- ignores empty lines
        ignore = "^$",

        -- This hook is used to use nvim-ts-context-commentstring API for calculating the `commentstring`
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      })
    end,
  },

  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "BufReadPost",
    config = true,
    -- stylua: ignore
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
      { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todos" },
    },
  },
}
