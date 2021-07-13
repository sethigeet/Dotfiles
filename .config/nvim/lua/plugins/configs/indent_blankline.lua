local plugin = {}

function plugin.setup()
  vim.g.indent_blankline_buftype_exclude = Opts.plugin.indent_blankline.config.buftype_exclude
  vim.g.indent_blankline_bufname_exclude = Opts.plugin.indent_blankline.config.bufname_exclude
  vim.g.indent_blankline_filetype_exclude = Opts.plugin.indent_blankline.config.filetype_exclude
  vim.g.indent_blankline_char = Opts.plugin.indent_blankline.config.char
  vim.g.indent_blankline_use_treesitter = Opts.plugin.indent_blankline.config.use_treesitter
  vim.g.indent_blankline_show_trailing_blankline_indent =
    Opts.plugin.indent_blankline.config.show_trailing_blankline_indent
  vim.g.indent_blankline_show_current_context = Opts.plugin.indent_blankline.config.show_current_context
  vim.g.indent_blankline_context_patterns = Opts.plugin.indent_blankline.config.context_patterns

  -- HACK: This is a workaround until this issue is not closed (https://github.com/lukas-reineke/indent-blankline.nvim/issues/59)
  vim.opt.colorcolumn = "9999999"

  -- BUG: Horizontal scrolling hides text! (https://github.com/lukas-reineke/indent-blankline.nvim/issues/51)
end

function plugin.config()
  Opts.plugin["indent_blankline"] = {
    enabled = true,
    config = {
      buftype_exclude = { "help", "terminal" },
      bufname_exclude = { "vifm*" },
      filetype_exclude = {
        "vimwiki",
        "NvimTree",
        "help",
        "undotree",
        "diff",
        "startify",
        "git",
        "dashboard",
        "neogitstatus",
      },
      char = "▏",
      use_treesitter = true,
      show_trailing_blankline_indent = false,
      show_current_context = true,
      context_patterns = {
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
      },
    },
  }
end

return plugin
