local plugin = {}

function plugin.setup()
  local DefineAugroups = require("general.functions").DefineAugroups

  DefineAugroups({
    NerdCommenter = {
      { "FileType", "javascriptreact,typescriptreact", [[setlocal commentstring={/*\ %s\ */}]] },
      { "BufRead,BufNewFile", "*.{jsx,js}", "setlocal filetype=javascriptreact" },
      { "BufRead,BufNewFile", "*.{tsx}", "setlocal filetype=typescriptreact" },
    },
  })

  require("nvim_comment").setup(Opts.plugin.comment.config)

  function Comment()
    if vim.fn.mode() == "n" then
      vim.cmd("CommentToggle")
    else
      vim.cmd("'<,'>CommentToggle")
    end
  end
end

function plugin.config()
  Opts.plugin["comment"] = {
    enabled = true,
    config = {
      -- Linters prefer comment and line to have a space in between markers
      marker_padding = true,
      -- should comment out empty or whitespace only lines
      comment_empty = false,
      -- Should key mappings be created
      create_mappings = false,
      -- Normal mode mapping left hand side
      line_mapping = "gcc",
      -- Visual/Operator mapping left hand side
      operator_mapping = "gc",
    },
  }
end

return plugin
