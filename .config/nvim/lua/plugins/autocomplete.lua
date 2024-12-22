local utils = require("utils")

local EMMET_ENABLED_FILETYPES = { "html", "css", "scss", "javascriptreact", "typescriptreact" }
local function is_emmet_enabled()
  local curr_ft = vim.opt.filetype:get()
  for _, ft in ipairs(EMMET_ENABLED_FILETYPES) do
    if curr_ft == ft then return true end
  end

  return false
end

local function tab_complete(fallback)
  local cmp = require("cmp")

  if cmp.visible() then
    cmp.select_next_item()
  elseif require("luasnip").jumpable(1) then
    vim.api.nvim_feedkeys(utils.t("<Plug>luasnip-jump-next"), "", true)
  elseif is_emmet_enabled() and utils.has_words_before() and not require("cmp").select_next_item() then
    vim.api.nvim_feedkeys(vim.fn["emmet#expandAbbrIntelligent"]("\\<Tab>"), "", true)
  else
    fallback()
  end
end

local function s_tab_complete(fallback)
  local cmp = require("cmp")

  if cmp.visible() then
    cmp.select_prev_item()
  elseif require("luasnip").jumpable(-1) then
    vim.api.nvim_feedkeys(utils.t("<Plug>luasnip-jump-prev"), "", true)
  else
    fallback()
  end
end

local function append_sources_to_buf(sources)
  local config = require("cmp.config")
  local temp_sources = vim.deepcopy(config.global.sources)
  for _, source in ipairs(sources) do
    table.insert(temp_sources, source)
  end

  require("cmp").setup.buffer({ sources = temp_sources })
end

local function make_snips(snips, ls)
  local result = {}
  for trig, exp in pairs(snips) do
    local expansion
    if type(exp) == "string" then
      expansion = { ls.text_node({ exp }), ls.insert_node(0) }
    elseif type(exp) == "table" then
      for k, v in ipairs(exp) do
        if type(v) == "string" then exp[k] = ls.text_node({ v }) end
      end
      expansion = exp
    end

    table.insert(result, ls.s({ trig = trig, desc = exp.desc }, expansion))
  end

  return result
end

return {
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-buffer",
      -- NOTE: The lsp plugin cannot be lazy loaded as `create_language_server` depends on it at startup
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-calc",
      "f3fora/cmp-spell",
      "ray-x/cmp-treesitter",
      "saadparwaiz1/cmp_luasnip",
    },
    opts = function()
      local cmp = require("cmp")

      return {
        snippet = {
          expand = function(args) require("luasnip").lsp_expand(args.body) end,
        },
        mapping = {
          ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "s" }),
          ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "s" }),
          ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
          ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),
          ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i" }),
          ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i" }),
          ["<C-n>"] = cmp.mapping({
            i = function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              else
                fallback()
              end
            end,
          }),
          ["<C-p>"] = cmp.mapping({
            i = function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              else
                fallback()
              end
            end,
          }),
          ["<Tab>"] = cmp.mapping({
            i = tab_complete,
            s = tab_complete,
          }),
          ["<S-Tab>"] = cmp.mapping({
            i = s_tab_complete,
            s = s_tab_complete,
          }),
          ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i" }),
          ["<C-q>"] = cmp.mapping(cmp.mapping.close(), { "i", "s" }),
          ["<C-e>"] = cmp.mapping(cmp.mapping.abort(), { "i", "s" }),
          ["<CR>"] = cmp.mapping({
            i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
            c = function(fallback)
              if cmp.visible() then
                cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
              else
                fallback()
              end
            end,
          }),
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "path" },
          { name = "calc" },
          { name = "emoji" },
          { name = "treesitter" },
          { name = "spell" },
          { name = "luasnip" },
          { name = "buffer", options = { max_completion_items = 15, keyword_length = 5 } },
        },
        window = {
          completion = {
            side_padding = 1,
            winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
            scrollbar = false,
          },
          documentation = cmp.config.window.bordered({
            border = "rounded",
            winhighlight = "Normal:CmpDoc,FloatBorder:CmpDocBorder,CursorLine:Visual,Search:None",
            scrollbar = false,
          }),
        },
        view = {
          entries = "custom",
        },
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(_, item)
            local icons = require("ui.icons")
            local icon = icons[item.kind] or ""
            item.kind = " " .. icon .. " "

            return item
          end,
        },
      }
    end,
    init = function()
      require("utils.wrappers").define_augroups({
        cmp_custom = {
          -- Turn on some sources in particular filetypes only
          {
            "FileType",
            "lua",
            cb = function() append_sources_to_buf({ { name = "nvim_lua" } }) end,
          },
        },
      })
    end,
  },

  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function() require("luasnip.loaders.from_vscode").lazy_load() end,
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
      updateevents = "TextChanged,TextChangedI",
    },
    init = function()
      local luasnip = require("luasnip")

      -- Load custom snippets
      for _, file in ipairs(vim.api.nvim_get_runtime_file("lua/snippets/*.lua", true)) do
        local name = vim.fn.fnamemodify(file, ":t:r")
        local contents = require("snippets." .. name)

        local fts, snips = contents["filetypes"], contents["snippets"]
        for _, ft in ipairs(fts) do
          luasnip.add_snippets(ft, make_snips(snips, luasnip))
        end
      end
    end,
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function(_, _)
      local npairs = require("nvim-autopairs")
      local Rule = require("nvim-autopairs.rule")

      -- Setup
      npairs.setup({
        check_ts = true,
        ts_config = {
          lua = { "string" }, -- it will not add pair on that treesitter node
          javascript = { "template_string" },
        },
        fast_wrap = {
          map = "<M-f>",
          end_key = "f",
          keys = "qwertyuiopzxcvbnmasdghjkl",
          -- highlight = "BufferCurrentTarget",
          highlight = "SelectNextKey",
        },
      })

      local rules = {}

      -- Add spaces between parentheses
      table.insert(
        rules,
        Rule(" ", " "):with_pair(function(opts)
          local pair = opts.line:sub(opts.col - 1, opts.col)
          return vim.tbl_contains({ "()", "[]", "{}" }, pair)
        end)
      )
      local parens = { { "(", ")" }, { "{", "}" }, { "[", "]" } }
      for _, paren in ipairs(parens) do
        table.insert(
          rules,
          Rule(paren[1] .. " ", " " .. paren[2])
            :with_pair(function() return false end)
            :with_move(function(opts) return opts.prev_char:match(".%" .. paren[2]) ~= nil end)
            :use_key(paren[2])
        )
      end

      -- Endwise
      local endwise = require("nvim-autopairs.ts-rule").endwise
      for _, rule in ipairs({
        -- HACK: Pass in `nil` instead of the treesitter node in some places as it does not work properly right now

        -- Lua
        endwise("if .* then$", "end", "lua", nil), -- "if_statement"
        endwise("function.*%(.*%)$", "end", "lua", nil), -- { "function_definition", "local_function", "function" }
        endwise("for .* do$", "end", "lua", nil), -- { "for_in_statement", "for_statement" }
        endwise("while .* do$", "end", "lua", nil), -- "while_statement"

        -- Shell
        endwise("if .*; then$", "fi", "sh", nil), -- "if_statement"
        endwise("while .*; do$", "done", "sh", nil), -- "while_statement"
        endwise("for .*; do$", "done", "sh", nil), -- { "c_style_for_statement", "for_statement" }
        endwise("until .*; do$", "done", "sh", nil), -- { "c_style_for_statement", "for_statement" }
        endwise("case .* in$", "esac", "sh", nil), -- "case_statement"
      }) do
        table.insert(rules, rule)
      end

      -- Language specific stuff
      -- JavaScript/TypeScript
      table.insert(
        rules,
        Rule("%(.*%)%s*%=>$", " {  }", { "javascript", "javascriptreact", "typescript", "typescriptreact" })
          :use_regex(true)
          :set_end_pair_length(2)
      )

      -- Add all the rules
      npairs.add_rules(rules)

      -- compe integration
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
}
