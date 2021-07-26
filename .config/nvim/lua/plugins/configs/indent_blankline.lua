local plugin = {}

function plugin.setup()
  vim.g.indent_blankline_buftype_exclude = { "help", "terminal" }
  vim.g.indent_blankline_bufname_exclude = { "vifm*" }
  vim.g.indent_blankline_filetype_exclude = {
    "vimwiki",
    "NvimTree",
    "help",
    "undotree",
    "diff",
    "startify",
    "git",
    "dashboard",
    "neogitstatus",
  }
  vim.g.indent_blankline_char = "▏"
  vim.g.indent_blankline_use_treesitter = true
  vim.g.indent_blankline_show_trailing_blankline_indent = false
  vim.g.indent_blankline_show_current_context = true
  vim.g.indent_blankline_context_patterns = {
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
  }

  -- HACK: This is a workaround until this issue is not closed (https://github.com/lukas-reineke/indent-blankline.nvim/issues/59)
  vim.opt.colorcolumn = "9999999"

  -- BUG: Horizontal scrolling hides text! (https://github.com/lukas-reineke/indent-blankline.nvim/issues/51)
end

return plugin
