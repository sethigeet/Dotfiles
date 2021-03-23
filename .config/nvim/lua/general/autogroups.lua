local define_augroups = require("general.functions").define_augroups

define_augroups({
    _general_settings = {
        {
            "TextYankPost", "*",
            'lua require("vim.highlight").on_yank({higroup = "IncSearch", timeout = 500})'
        }, {"BufWinEnter", "*", "setlocal formatoptions-=c formatoptions-=r formatoptions-=o"},
        {"BufRead", "*", "setlocal formatoptions-=c formatoptions-=r formatoptions-=o"},
        {"BufNewFile", "*", "setlocal formatoptions-=c formatoptions-=r formatoptions-=o"},
        {"BufWinEnter", "*.*", "silent!", "loadview"}, -- Save the state for the next time
        {"BufWinLeave", "*.*", "mkview"}, -- Save the state for the next time
        {"FileType", "markdown", "set wrap"},
        -- set the timeout length for mappings (By default timeoutlen=1000)
        {"InsertEnter", "*", "set timeoutlen=1000"}, {"InsertLeave", "*", "set timeoutlen=100"},
        -- Automatically install plugins when the plugins file is updated
        {"BufWritePost", "plugins.lua", "PackerCompile"},
        -- Vertically center document when entering insert mode
        {"InsertEnter", "*", "norm zz"}
    },

    markdown = {
        {
            "FileType", "markdown",
            'noremap ,r i---<CR>title:<Space><++><CR>author:<Space>"Geet Sethi"<CR>geometry:<CR>-<Space>top=30mm<CR>-<Space>left=20mm<CR>-<Space>right=20mm<CR>-<Space>bottom=30mm<CR>header-includes:<Space>\\|<CR><Tab>\\usepackage{float}<CR>\\let\\origfigure\\figure<CR>\\let\\endorigfigure\\endfigure<CR>\\renewenvironment{figure}[1][2]<Space>{<CR><Tab>\\expandafter\\origfigure\\expandafter[H]<CR><BS>}<Space>{<CR><Tab>\\endorigfigure<CR><BS>}<CR><BS>---<CR><CR>'
        },
        {"FileType", "markdown", "inoremap ,i ![](<++>){#fig:<++>}<Space><CR><CR><++><Esc>kkF]i"},
        {"FileType", "markdown", "inoremap ,a [](<++>)<Space><++><Esc>F]i"},
        {"FileType", "markdown", "inoremap ,1 #<Space><CR><CR><++><Esc>2k<S-a>"},
        {"FileType", "markdown", "inoremap ,2 ##<Space><CR><CR><++><Esc>2k<S-a>"},
        {"FileType", "markdown", "inoremap ,3 ###<Space><CR><CR><++><Esc>2k<S-a>"},
        {"FileType", "markdown", "inoremap ,4 ####<Space><CR><CR><++><Esc>2k<S-a>"},
        {"FileType", "markdown", "inoremap ,5 #####<Space><CR><CR><++><Esc>2k<S-a>"},
        {"FileType", "markdown", "inoremap ,u +<Space><CR><++><Esc>1k<S-a>"},
        {"FileType", "markdown", "inoremap ,o 1.<Space><CR><++><Esc>1k<S-a>"},
        {"FileType", "markdown", "inoremap ,f +@fig:"}, {'FileType', 'markdown', 'setlocal wrap'},
        {'FileType', 'markdown', 'setlocal spell'}
    },

    shell = {
        {"FileType", "sh", "map ,b i#!/usr/bin/env <CR><CR><Esc>2kA"},
        {"FileType", "sh", "inoremap ,f ()<Space>{<CR><Tab><++><CR>}<CR><CR><++><Esc>?()<CR>"}, {
            "FileType", "sh",
            "inoremap ,i if<Space>[<Space>];<Space>then<CR><++><CR>fi<CR><CR><++><Esc>?];<CR>hi<Space>"
        }, {
            "FileType", "sh",
            "inoremap ,ei elif<Space>[<Space>];<Space>then<CR><++><CR><Esc>?];<CR>hi<Space>"
        }, {
            "FileType", "sh",
            'inoremap ,sw case<Space>""<Space>in<CR><++>)<Space><++><Space>;;<CR><++><CR>esac<CR><CR><++><Esc>?"<CR>i'
        }, {"FileType", "sh", "inoremap ,ca )<Space><++><Space>;;<CR><++><Esc>?)<CR>i"}
    }
})
