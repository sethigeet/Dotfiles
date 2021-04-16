-- local lspconfig = require("lspconfig/configs")
local util = require("lspconfig/util")

local custom_lsps = {}

function custom_lsps.Emmet()
    -- Add emmet-ls entry to nvim-lspconfig
    require("lspconfig/configs").emmetls = {
        default_config = {
            cmd = { "emmet-ls", "--stdio" },
            cmd_env = {
                -- Prevent recursive scanning which will cause issues when opening a file
                -- directly in the home directory (e.g. ~/foo.sh).
                GLOB_PATTERN = vim.env.GLOB_PATTERN or "*@(.css|.html|.html5|.css3|.scss|.jsx|.tsx)"
            },
            filetypes = { "html", "css", "scss", "jsx", "javascriptreact", "tsx", "typescriptreact" },
            root_dir = util.path.dirname
        },
        docs = {
            description = [[
https://github.com/aca/emmet-ls
Emmet support based on LSP.
]],
            default_config = { root_dir = "vim's starting directory" }
        }
    }

    local config = require("lspconfig").emmetls.document_config
    require("lspconfig/configs").emmetls = nil -- important, unset the loaded config again

    config.default_config.cmd[1] = "./node_modules/.bin/emmet-ls"

    require("lspinstall/servers").emmet = vim.tbl_extend("error", config, {
        install_script = [=[
    [[ ! -f package.json ]] && npm init -y --scope=lspinstall || true
    npm install emmet-ls@latest
    ]=]
    })
end

return custom_lsps

