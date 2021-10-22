local utils = require("utils")

local plugin = {}

local function tab_complete(fallback)
  local cmp = require("cmp")

  if cmp.visible() then
    vim.api.nvim_feedkeys(utils.t("<C-n>"), "n", true)
  elseif utils.has_words_before() and require("luasnip").expand_or_jumpable() then
    vim.api.nvim_feedkeys(utils.t("<Plug>luasnip-expand-or-jump"), "", true)
  elseif utils.has_words_before() and not require("cmp").select_next_item() then
    vim.api.nvim_feedkeys(vim.fn["emmet#expandAbbrIntelligent"]("\\<Tab>"), "", true)
  else
    fallback()
  end
end

local function s_tab_complete(fallback)
  local cmp = require("cmp")

  if cmp.visible() then
    vim.api.nvim_feedkeys(utils.t("<C-p>"), "n", true)
  elseif require("luasnip").jumpable(-1) then
    vim.api.nvim_feedkeys(utils.t("<Plug>luasnip-jump-prev"), "", true)
  else
    fallback()
  end
end

function plugin.setup()
  local cmp = require("cmp")

  cmp.setup({
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    mapping = {
      ["<C-u>"] = cmp.mapping.scroll_docs(-4),
      ["<C-d>"] = cmp.mapping.scroll_docs(4),

      ["<C-j>"] = cmp.mapping.select_next_item(),
      ["<C-k>"] = cmp.mapping.select_prev_item(),
      ["<Tab>"] = cmp.mapping(tab_complete, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(s_tab_complete, { "i", "s" }),

      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.close(),
      ["<CR>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      }),
    },
    sources = {
      { name = "nvim_lsp" },
      { name = "path" },
      { name = "calc" },
      { name = "emoji" },
      { name = "treesitter" },
      { name = "spell" },
      { name = "nvim_lua" }, -- NOTE: This source only enables itself for lua files
      { name = "vim-dadbod-completion" },
      { name = "luasnip" },
      { name = "buffer", max_completion_items = 15, keyword_length = 5 },
    },
    documentation = {
      border = "rounded",
      winhighlight = "FloatBorder:FloatBorder",
    },
    formatting = {
      format = function(_, vim_item)
        local icons = require("lsp.kind")
        vim_item.kind = icons[vim_item.kind]
        return vim_item
      end,
    },
  })

  plugin.define_augroups()
end

function plugin.append_sources_to_buf(sources)
  local config = require("cmp.config")
  local temp_sources = vim.deepcopy(config.global.sources)
  for _, source in ipairs(sources) do
    table.insert(temp_sources, source)
  end

  require("cmp").setup.buffer({ sources = temp_sources })
end

function plugin.define_augroups()
  require("utils").define_augroups({
    cmp_custom = {
      { "FileType", "TelescopePrompt", "lua require('cmp').setup.buffer({ enabled = false })" },
    },
  })
end

return plugin
