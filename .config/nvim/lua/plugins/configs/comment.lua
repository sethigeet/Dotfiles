local plugin = {}

function plugin.setup()
  require("nvim_comment").setup({
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
  })

  plugin.defineFunctions()
end

function plugin.defineFunctions()
  function _G.Comment()
    if vim.fn.mode() == "n" then
      vim.cmd("CommentToggle")
    else
      vim.cmd("'<,'>CommentToggle")
    end
  end
end

return plugin
