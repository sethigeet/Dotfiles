-- Lines and numbers
Opts.wrap_lines = false
Opts.number = true
Opts.relative_number = true

-- Minimum number of line to keep above and below the cursor
Opts.scroll_off = 2

-- Colorscheme
Opts.colorscheme = "tokyonight"

-- Tree
Opts.auto_close_tree = true
Opts.hidden_files = true

-- Default shell
Opts.shell = "zsh"

-- Auto complete
Opts.auto_complete = true

-- Treesitter
Opts.treesitter.ensure_installed = "all"
Opts.treesitter.ignore_install = {}
Opts.treesitter.highlight.enable = true
Opts.treesitter.rainbow.enable = true
Opts.treesitter.autotag.enable = true
Opts.treesitter.indent.enable = false
Opts.treesitter.autopairs.enable = true

-- Database Interaction
Opts.database.save_location = DATA_PATH .. "/dadbod.db"
Opts.database.auto_execute = 1

-- LSP
-- EFM Language Server (Multipurpose language server being used mainly for formatting right now)
Opts.lsp.efm_langserver.autoformat = true
Opts.lsp.efm_langserver.diagnostics.virtual_text = { spacing = 0, prefix = "" }
Opts.lsp.efm_langserver.diagnostics.signs = true
Opts.lsp.efm_langserver.diagnostics.underline = true

-- Python2 and Python3
Opts.lsp.python.autoformat = true
Opts.lsp.python.diagnostics.virtual_text = { spacing = 0, prefix = "" }
Opts.lsp.python.diagnostics.signs = true
Opts.lsp.python.diagnostics.underline = true

-- Lua
Opts.lsp.lua.autoformat = true
Opts.lsp.lua.diagnostics.virtual_text = { spacing = 0, prefix = "" }
Opts.lsp.lua.diagnostics.signs = true
Opts.lsp.lua.diagnostics.underline = true

-- Shell (sh, bash, zsh, etc.)
Opts.lsp.sh.autoformat = true
Opts.lsp.sh.diagnostics.virtual_text = { spacing = 0, prefix = "" }
Opts.lsp.sh.diagnostics.signs = true
Opts.lsp.sh.diagnostics.underline = true

-- JavaScript and TypeScript
Opts.lsp.typescript.autoformat = true
Opts.lsp.typescript.diagnostics.virtual_text = { spacing = 0, prefix = "" }
Opts.lsp.typescript.diagnostics.signs = true
Opts.lsp.typescript.diagnostics.underline = true

-- JSON
Opts.lsp.json.autoformat = true
Opts.lsp.json.diagnostics.virtual_text = { spacing = 0, prefix = "" }
Opts.lsp.json.diagnostics.signs = true
Opts.lsp.json.diagnostics.underline = true

-- HTML
Opts.lsp.html.autoformat = true
Opts.lsp.html.diagnostics.virtual_text = { spacing = 0, prefix = "" }
Opts.lsp.html.diagnostics.signs = true
Opts.lsp.html.diagnostics.underline = true

-- CSS
Opts.lsp.css.autoformat = true
Opts.lsp.css.diagnostics.virtual_text = { spacing = 0, prefix = "" }
Opts.lsp.css.diagnostics.signs = true
Opts.lsp.css.diagnostics.underline = true

-- Emmet
Opts.lsp.emmet.autoformat = true
Opts.lsp.emmet.diagnostics.virtual_text = { spacing = 0, prefix = "" }
Opts.lsp.emmet.diagnostics.signs = true
Opts.lsp.emmet.diagnostics.underline = true

-- Docker
Opts.lsp.docker.autoformat = true
Opts.lsp.docker.diagnostics.virtual_text = { spacing = 0, prefix = "" }
Opts.lsp.docker.diagnostics.signs = true
Opts.lsp.docker.diagnostics.underline = true

-- Graphql
Opts.lsp.graphql.autoformat = true
Opts.lsp.graphql.diagnostics.virtual_text = { spacing = 0, prefix = "" }
Opts.lsp.graphql.diagnostics.signs = true
Opts.lsp.graphql.diagnostics.underline = true

-- Go
Opts.lsp.go.autoformat = true
Opts.lsp.go.diagnostics.virtual_text = { spacing = 0, prefix = "" }
Opts.lsp.go.diagnostics.signs = true
Opts.lsp.go.diagnostics.underline = true

-- Vim
Opts.lsp.vim.autoformat = true
Opts.lsp.vim.diagnostics.virtual_text = { spacing = 0, prefix = "" }
Opts.lsp.vim.diagnostics.signs = true
Opts.lsp.vim.diagnostics.underline = true

-- Yaml
Opts.lsp.yaml.autoformat = true
Opts.lsp.yaml.diagnostics.virtual_text = { spacing = 0, prefix = "" }
Opts.lsp.yaml.diagnostics.signs = true
Opts.lsp.yaml.diagnostics.underline = true

-- Git
Opts.git.show_blame = true
Opts.git.show_signs = true

