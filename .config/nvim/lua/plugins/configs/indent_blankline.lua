local Plugin = require("plugins.plugin")

return Plugin:create({
  configure = function()
    require("indent_blankline").setup({
      buftype_exclude = { "help", "terminal" },
      bufname_exclude = { "vifm*" },
      filetype_exclude = {
        "vimwiki",
        "NvimTree",
        "help",
        "undotree",
        "diff",
        "git",
        "alpha",
        "neogitstatus",
        "packer",
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
    })

    -- HACK: This is a workaround until this issue is not closed (https://github.com/lukas-reineke/indent-blankline.nvim/issues/59)
    vim.opt.colorcolumn = "9999999"
  end,
})
