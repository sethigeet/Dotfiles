-- require("nvim-web-devicons").setup()
local gl = require("galaxyline")
local condition = require('galaxyline.condition')

local gls = gl.section

local colors = {
    bg = "#282c34",
    yellow = "#fabd2f",
    cyan = "#008080",
    darkblue = "#081633",
    green = "#608B4E",
    orange = "#FF8800",
    purple = "#5d4d7a",
    magenta = "#d16d9e",
    grey = "#c0c0c0",
    blue = "#569CD6",
    red = "#D16969"
}

gl.short_line_list = {'NvimTree', 'vista', 'dbui', 'packer'}

gls.left[1] = {
    ViMode = {
        provider = function()

            local mode = vim.fn.mode()
            -- auto change color according the vim mode
            local mode_color = {
                n = colors.purple,
                i = colors.green,
                v = colors.blue,
                [""] = colors.blue,
                V = colors.blue,
                c = colors.purple,
                no = colors.magenta,
                s = colors.orange,
                S = colors.orange,
                [""] = colors.orange,
                ic = colors.yellow,
                R = colors.red,
                Rv = colors.red,
                cv = colors.red,
                ce = colors.red,
                r = colors.cyan,
                rm = colors.cyan,
                ["r?"] = colors.cyan,
                ["!"] = colors.red,
                t = colors.red
            }
            vim.api.nvim_command("hi GalaxyViMode guibg=" .. mode_color[mode])

            local mode_name = {
                c = "COMMAND",
                ce = "NORMAL EX",
                cv = "EX",
                i = "INSERT",
                ic = "INS-COMPLETE",
                n = "NORMAL",
                no = "OPERATOR PENDING",
                r = "HIT ENTER",
                ['r?'] = ":CONFIRM",
                rm = "--MORE",
                R = "REPLACE",
                Rv = "VIRTUAL",
                s = "SELECT",
                S = "SELECT",
                [''] = "SELECT",
                t = "TERMINAL",
                v = "VISUAL",
                V = "VISUAL LINE",
                [''] = "VISUAL BLOCK",
                ['!'] = "SHELL"
            }

            return "  " .. mode_name[mode] .. " "
        end,
        separator = " ",
        separator_highlight = {
            colors.yellow, function()
                if not condition.buffer_not_empty then return colors.bg end
                return colors.bg
            end
        },
        highlight = {colors.grey, colors.bg, "bold"}
    }
}

gls.left[2] = {
    GitIcon = {
        provider = function()
            return " "
        end,
        condition = condition.check_git_workspace,
        highlight = {colors.orange, colors.bg}
    }
}

gls.left[3] = {
    GitBranch = {
        provider = "GitBranch",
        separator = " ",
        separator_highlight = {colors.purple, colors.bg},
        condition = condition.check_git_workspace,
        highlight = {colors.grey, colors.bg}
    }
}

gls.left[4] = {
    DiffAdd = {
        provider = "DiffAdd",
        condition = condition.hide_in_width,
        icon = '  ',
        highlight = {colors.green, colors.bg}
    }
}

gls.left[5] = {
    DiffModified = {
        provider = "DiffModified",
        condition = condition.hide_in_width,
        icon = ' 柳',
        highlight = {colors.blue, colors.bg}
    }
}

gls.left[6] = {
    DiffRemove = {
        provider = "DiffRemove",
        condition = condition.hide_in_width,
        icon = '  ',
        highlight = {colors.red, colors.bg}
    }
}

gls.left[7] = {
    LeftEnd = {
        provider = function()
            return " "
        end,
        separator = " ",
        separator_highlight = {colors.purple, colors.bg},
        highlight = {colors.purple, colors.bg}
    }
}

gls.left[8] = {
    DiagnosticError = {
        provider = "DiagnosticError",
        icon = "  ",
        highlight = {colors.red, colors.bg}
    }
}

gls.left[9] = {
    Space = {
        provider = function()
            return ""
        end
    }
}

gls.left[10] = {
    DiagnosticWarn = {
        provider = "DiagnosticWarn",
        icon = "  ",
        highlight = {colors.yellow, colors.bg}
    }
}

gls.left[11] = {
    DiagnosticHint = {
        provider = "DiagnosticHint",
        icon = "   ",
        highlight = {colors.blue, colors.bg}
    }
}

gls.left[12] = {
    DiagnosticInfo = {
        provider = "DiagnosticInfo",
        icon = "  כֿ ",
        highlight = {colors.orange, colors.bg}
    }
}

gls.right[1] = {
    ShowLspClient = {
        provider = 'GetLspClient',
        condition = function()
            local tbl = {['dashboard'] = true, [' '] = true}
            if tbl[vim.bo.filetype] then return false end
            return true
        end,
        icon = ' ',
        highlight = {colors.grey, colors.bg, 'bold'}
    }
}

gls.right[2] = {
    FileFormat = {
        provider = "FileTypeName",
        separator = " | ",
        separator_highlight = {colors.darkblue, colors.bg},
        highlight = {colors.grey, colors.bg}
    }
}

gls.right[3] = {
    LineInfo = {
        provider = "LineColumn",
        separator = " | ",
        separator_highlight = {colors.darkblue, colors.bg},
        highlight = {colors.grey, colors.bg}
    }
}

gls.right[4] = {
    PerCent = {
        provider = "LinePercent",
        separator = " |",
        separator_highlight = {colors.darkblue, colors.bg},
        highlight = {colors.grey, colors.bg}
    }
}

gls.right[5] = {ScrollBar = {provider = "ScrollBar", highlight = {colors.yellow, colors.purple}}}

gls.short_line_left[1] = {
    BufferType = {
        provider = "FileTypeName",
        separator = " ",
        separator_highlight = {colors.purple, colors.bg},
        highlight = {colors.grey, colors.purple}
    }
}

gls.short_line_left[2] = {
    SFileName = {
        provider = 'SFileName',
        condition = condition.buffer_not_empty,
        highlight = {colors.grey, colors.bg, 'bold'}
    }
}

gls.short_line_right[1] = {
    BufferIcon = {provider = 'BufferIcon', highlight = {colors.grey, colors.bg}}
}

