local wk = require("which-key")

wk.setup({
    plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
            operators = false, -- adds help for operators like d, y, ...
            motions = false, -- adds help for motions
            text_objects = false, -- help for text objects triggered after entering an operator
            windows = true, -- default bindings on <c-w>
            nav = false, -- misc bindings to work with windows
            z = true, -- bindings for folds, spelling and others prefixed with z
            g = true -- bindings for prefixed with g
        }
    },
    icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = " " -- symbol prepended to a group
    },
    window = {
        border = "none", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = { 1, 0, 0, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 1, 1, 1, 1 } -- extra window padding [top, right, bottom, left]
    },
    layout = {
        height = { min = 5, max = 15 }, -- min and max height of the columns
        width = { min = 4, max = 50 }, -- min and max width of the columns
        spacing = 3 -- spacing between columns
    },
    hidden = { "<silent>", ":", "<cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
    show_help = true -- show help message on the command line when the popup is visible
})

-- Set leader
vim.api.nvim_set_keymap("n", "<Space>", "<NOP>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<Space>", "<NOP>", { noremap = true, silent = true })
vim.g.mapleader = " "

-- Hide the status line for the which-key window
require("general.functions").define_augroups({
    which_key = {
        { "FileType", "which_key", "set laststatus=0 noshowmode noruler" },
        { "BufLeave", "<buffer>", "set laststatus=2 noshowmode ruler" }
    }
})

local function getOpts(mode, emptyPrefix)
    local prefix
    if emptyPrefix then
        prefix = ""
    else
        prefix = "<leader>"
    end

    return {
        mode = mode, -- NORMAL mode
        -- prefix: use "<leader>f" for example for mapping everything related to finding files
        -- the prefix is prepended to every mapping part of `mappings`
        prefix = prefix,
        buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
        silent = true, -- use `silent` when creating keymaps
        noremap = true, -- use `noremap` when creating keymaps
        nowait = false -- use `nowait` when creating keymaps
    }
end

local mappings = {
    ["/"] = { ":call v:lua.Comment()<CR>", "comment" },
    ["?"] = { ":NvimTreeFindFile<CR>", "show file in tree" },
    ["="] = { "<C-W>=", "balance windows" },
    [";"] = { ":Dashboard<CR>", "Show start screen" },
    e = { ":NvimTreeToggle<CR>", "explorer" },
    f = { ":Telescope find_files<CR>", "find files" },
    h = { "<C-W>s", "split below" },
    j = { ":lprev<CR>zz", "prev location list item" },
    k = { ":lnext<CR>zz", "next location list item" },
    M = { ":MarkdownPreviewToggle<CR>", "markdown preview" },
    n = { ":let @/ = \"\"<CR>", "no highlight" },
    u = { ":UndotreeToggle<CR>", "undo tree" },
    v = { "<C-W>v", "split right" },
    z = { "Goyo", "zen mode" },

    -- a is for Action
    a = {
        name = "Actions",
        c = { ":ColorizerToggle<CR>", "colorizer" },
        h = { ":nohl<CR>", "remove search highlight" },
        i = { ":IndentBlanklineToggle<CR>", "toggle indent lines" },
        l = { ":Bracey<CR>", "start live server" },
        L = { ":BraceyStop<CR>", "stop live server" },
        m = { ":Glow<CR>", "markdown preview" },
        n = { ":set nonumber!<CR>", "line-numbers" },
        s = { "<Plug>SortMotionVisual", "sort selected text" },
        r = { ":set norelativenumber!<CR>", "relative line nums" },
        t = { ":FloatermToggle<CR>", "terminal" },
        v = { ":Codi<CR>", "virtual repl on" },
        V = { ":Codi!<CR>", "virtual repl off" }
    },

    -- b is for Buffer
    b = {
        name = "Buffer",
        [">"] = { ":BufferMoveNext<CR>", "move next" },
        ["<"] = { ":BufferMovePrevious<CR>", "move prev" },
        ["1"] = { ":BufferGoto 1<CR>", "buffer 1" },
        ["2"] = { ":BufferGoto 2<CR>", "buffer 2" },
        ["3"] = { ":BufferGoto 3<CR>", "buffer 3" },
        ["4"] = { ":BufferGoto 4<CR>", "buffer 4" },
        ["5"] = { ":BufferGoto 5<CR>", "buffer 5" },
        ["6"] = { ":BufferGoto 6<CR>", "buffer 6" },
        ["7"] = { ":BufferGoto 7<CR>", "buffer 7" },
        ["8"] = { ":BufferGoto 8<CR>", "buffer 8" },
        ["9"] = { ":BufferGoto 9<CR>", "buffer 9" },
        ["0"] = { ":BufferGoto 0<CR>", "buffer 0" },
        b = { ":BufferPick<CR>", "pick buffer" },
        d = { ":Bdelete<CR>", "delete buffer" },
        D = { ":BufferOrderByDirectory<CR>", "order by directory" },
        f = { "bfirst", "first buffer" },
        l = { "blast", "last buffer" },
        L = { ":BufferOrderByLanguage<CR>", "order by language" },
        n = { "bnext", "next buffer" },
        p = { "bprevious", "previous-buffer" }
    },

    -- d is for Database
    d = {
        name = "Database",
        t = { ":DBUIToggle<CR>", "toggle ui" },
        f = { ":DBUIFindBuffer<CR>", "find buffer" },
        r = { ":DBUIRenameBuffer<CR>", "rename buffer" },
        i = { ":DBUILastQueryInfo<CR>", "last query info" }
    },

    -- F is for Fold
    F = {
        name = "Fold",
        O = { ":set foldlevel=20<CR>", "open all" },
        C = { ":set foldlevel=0<CR>", "close all" },
        c = { ":foldclose<CR>", "close" },
        o = { ":foldopen<CR>", "open" },
        ["1"] = { ":set foldlevel=1<CR>", "level 1" },
        ["2"] = { ":set foldlevel=2<CR>", "level 2" },
        ["3"] = { ":set foldlevel=3<CR>", "level 3" },
        ["4"] = { ":set foldlevel=4<CR>", "level 4" },
        ["5"] = { ":set foldlevel=5<CR>", "level 5" },
        ["6"] = { ":set foldlevel=6<CR>", "level 6" }
    },

    -- g is for Git
    g = {
        name = "Git",
        a = { ":Git add .<CR>", "add all" },
        -- b = { ":Git blame<CR>", "blame" },
        b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
        B = { ":GBrowse<CR>", "browse" },
        c = {
            name = "Commits",
            c = { ":Git commit<CR>", "commit" },
            o = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
            u = { "<cmd>Telescope git_bcommits<cr>", "Checkout commit(for current file)" }
        },
        d = { ":Git diff<CR>", "diff" },
        D = { ":Gdiffsplit<CR>", "diff split" },
        g = { ":GGrep<CR>", "git grep" },
        G = { ":Gstatus<CR>", "status" },
        H = { ":PreviewHunk<CR>", "preview hunk" },
        j = { ":NextHunk<CR>", "next hunk" },
        k = { ":PrevHunk<CR>", "prev hunk" },
        l = { ":Git log<CR>", "log" },
        m = { "<Plug>(git-messenger)<CR>", "message" },
        p = { ":Git push<CR>", "push" },
        P = { ":Git pull<CR>", "pull" },
        r = { ":GRemove<CR>", "remove" },
        R = { ":ResetHunk<CR>", "reset hunk" },
        s = { ":StageHunk<CR>", "stage hunk" },
        t = { ":GitGutterSignsToggle<CR>", "toggle signs" },
        u = { ":UndoStageHunk<CR>", "undo stage hunk" },
        S = { "<cmd>Telescope git_status<cr>", "Open changed file" },
        v = { ":GV<CR>", "view commits" },
        V = { ":GV!<CR>", "view buffer commits" },
        A = { ":Git add %<CR>", "add current" }
        -- S = { ":!git status<CR>", "status" }
    },

    -- l is for LSP
    l = {
        name = "LSP",
        a = { ":Lspsaga code_action<CR>", "code actions" },
        A = { ":Lspsaga range_code_action<CR>", "selected action" },
        d = { ":Telescope lsp_document_diagnostics<CR>", "document diagnostics" },
        D = { ":Telescope lsp_workspace_diagnostics<CR>", "workspace diagnostics" },
        f = { ":LspFormatting<CR>", "format" },
        H = { ":Lspsaga signature_help<CR>", "signature_help" },
        I = { ":LspInfo<CR>", "lsp info" },
        l = { ":Lspsaga lsp_finder<CR>", "lsp finder" },
        L = { ":Lspsaga show_line_diagnostics<CR>", "line diagnostics" },
        o = { ":SymbolsOutline<CR>", "outline" },
        p = { ":Lspsaga preview_definition<CR>", "preview definition" },
        P = { ":call v:lua.PeekDefinition()<CR>", "peek definition" },
        q = { ":Telescope quickfix<CR>", "quickfix" },
        r = { ":Lspsaga rename<CR>", "rename" },
        T = { ":LspTypeDefinition<CR>", "type defintion" },
        x = { ":cclose<CR>", "close quickfix" },
        v = { ":LspVirtualTextToggle<CR>", "toggle virtual text" },
        s = { ":Telescope lsp_document_symbols<CR>", "document symbols" },
        S = { ":Telescope lsp_workspace_symbols<CR>", "workspace symbols" }

        -- D = {":LspDeclaration<CR>", "workspace_diagnostics" },
        -- r = {":Telescope lsp_references<CR>", "references" },
        -- p = {":Lspsaga diagnostic_jump_prev<CR>", "prev diagnostic" },
        -- n = {":Lspsaga diagnostic_jump_next<CR>", "next_diagnostic" },
        -- q = {":Lspsaga code_action<CR>", "quickfix" },
        -- i = {":LspImplementation<CR>", "lsp_info" },
        -- h = {":Lspsaga hover_doc<CR>", "hover_doc" },
        -- K = {":LspHover<CR>", "hover" }
    },

    -- m is for Mark
    m = {
        name = "Mark",
        t = { ":BookmarkToggle<CR>", "toggle" },
        j = { ":BookmarkNext<CR>", "next mark" },
        k = { ":BookmarkPrev<CR>", "prev mark" }
    },

    -- p is for Peekup
    p = {
        name = "Peekup",
        p = { "<Plug>PeekupOpen<CR>", "view registers" },
        b = { "<Plug>PeekupPasteBefore<CR>", "view registers & paste before cursor upon selection" },
        a = { "<Plug>PeekupPasteAfter<CR>", "view registers & paste after cursor upon selection" }
    },

    -- q is for Quickfix
    q = {
        name = "Quickfix",
        w = { ":LspTrouble lsp_workspace_diagnostics<CR>", "lsp workspace diagnostics" },
        d = { ":LspTrouble lsp_document_diagnostics<CR>", "lsp document diagnostics" },
        r = { ":LspTrouble lsp_references<CR>", "lsp references" },
        q = { ":call v:lua.ToggleQFList(1)<CR>", "quickfix list" },
        l = { ":call v:lua.ToggleQFList(0)<CR>", "location list" }
    },

    r = {
        name = "Run",
        r = { "<Plug>SnipRun<CR>", "Run the selected piece of code" },
        s = { "<Plug>SnipReset<CR>", "Stop the running code" },
        c = { "<Plug>SnipClose<CR>", "Clear the previous output" },
        m = { "<Plug>SnipReplMemoryClean<CR>", "Clean the repl memory" }
    },

    -- s is for Search
    s = {
        name = "Search",
        ["."] = { ":Telescope filetypes<CR>", "filetypes" },
        [";"] = { ":Telescope commands<CR>", "commands" },
        a = { ":Telescope lsp_code_actions<CR>", "code actions" },
        A = { ":Telescope builtin<CR>", "all" },
        b = { ":Telescope buffers<CR>", "buffers" },
        B = { ":Telescope git_branches<CR>", "git branches" },
        d = { ":Telescope lsp_document_diagnostics<CR>", "document diagnostics" },
        D = { ":Telescope lsp_workspace_diagnostics<CR>", "workspace diagnostics" },
        c = { ":Telescope git_commits<CR>", "git commits" },
        f = { ":Telescope find_files<CR>", "files" },
        F = { ":Telescope git_files<CR>", "git files" },
        g = { ":Telescope tags<CR>", "tags" },
        G = { ":Telescope current_buffer_tags<CR>", "buffer_tags" },
        h = { ":Telescope command_history<CR>", "history" },
        H = { ":Telescope help_tags<CR>", "help_tags" },
        i = { ":Telescope media_files<CR>", "media files" },
        k = { ":Telescope keymaps<CR>", "keymaps" },
        l = { ":Telescope loclist<CR>", "loclist" },
        m = { ":Telescope marks<CR>", "marks" },
        M = { ":Telescope man_pages<CR>", "man pages" },
        o = { ":Telescope vim_options<CR>", "vim options" },
        O = { ":Telescope oldfiles<CR>", "oldfiles" },
        p = { ":Telescope fd<CR>", "fd" },
        P = { ":Telescope spell_suggest<CR>", "spell suggest" },
        s = { ":Telescope git_status<CR>", "git status" },
        S = { ":Telescope grep_string<CR>", "grep string" },
        t = { ":Telescope live_grep<CR>", "text" },
        y = { ":Telescope symbols<CR>", "symbols" },
        Y = { ":Telescope lsp_workspace_symbols<CR>", "lsp workspace symbols" },
        r = { ":Telescope registers<CR>", "registers" },
        R = { ":Telescope reloader<CR>", "reloader" },
        w = { ":Telescope file_browser<CR>", "file browser" },
        u = { ":Telescope colorscheme<CR>", "colorschemes" },
        z = { ":Telescope current_buffer_fuzzy_find<CR>", "buf fuz find" }
    },

    -- S is for Session
    S = {
        name = "Session",
        s = { ":SessionSave<CR>", "save session" },
        l = { ":SessionLoad<CR>", "load Session" }
    },

    -- t is for Terminal
    t = {
        name = "Terminal",
        [";"] = { ":FloatermNew --wintype=normal --height=6<CR>", "terminal" },
        b = { ":FloatermNew bpytop<CR>", "bpytop" },
        g = { ":FloatermNew lazygit<CR>", "git" },
        d = { ":FloatermNew lazydocker<CR>", "docker" },
        n = { ":FloatermNew node<CR>", "node" },
        p = { ":FloatermNew python<CR>", "python" },
        m = { ":FloatermNew lazynpm<CR>", "npm" },
        t = { ":FloatermToggle<CR>", "toggle" },
        v = { ":FloatermNew vifm<CR>", "vifm" }
    }
}

wk.register(mappings, getOpts("n"))
wk.register(mappings, getOpts("v"))

wk.register({ j = "which_key_ignore", k = "which_key_ignore", ["<Space>"] = "which_key_ignore" },
            getOpts("i", true))
