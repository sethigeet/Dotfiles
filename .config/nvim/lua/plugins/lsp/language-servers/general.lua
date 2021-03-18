local lspconfig = require("lspconfig")

lspconfig.efm.setup {
    init_options = {documentFormatting = true},
    filetypes = {"lua", "javascript", "typescript"},
    root_dir = function(fname)
        return lspconfig.util.root_pattern("tsconfig.json")(fname) or
                   lspconfig.util.root_pattern(".eslintrc.json")(fname) or
                   lspconfig.util.root_pattern(".git")(fname);
    end,
    settings = {
        rootMarkers = {".git/", ".eslintrc.json"},
        languages = {
            lua = {
                {
                    formatCommand = "lua-format -i --no-keep-simple-function-one-line --column-limit=100",
                    formatStdin = true
                }
            },
            typescript = {
                lintCommand = "./node_modules/.bin/eslint -f unix --stdin --stdin-filename ${INPUT}",
                lintIgnoreExitCode = true,
                lintStdin = true,
                formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
                formatStdin = true
            }
        }
    }
}
