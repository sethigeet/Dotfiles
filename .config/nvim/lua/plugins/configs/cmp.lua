local utils = require("utils")

local plugin = {}

local function tab_complete(fallback)
  if vim.fn.pumvisible() == 1 then
    vim.api.nvim_feedkeys(utils.t("<C-n>"), "n", true)
  elseif utils.has_words_before() and vim.fn["vsnip#available"]() == 1 then
    print("in vsnip")
    vim.api.nvim_feedkeys(utils.t("<Plug>(vsnip-expand-or-jump)"), "", true)
  elseif utils.has_words_before() and not require("cmp").select_next_item() then
    vim.api.nvim_feedkeys(vim.fn["emmet#expandAbbrIntelligent"]("\\<Tab>"), "", true)
  else
    fallback()
  end
end

local function s_tab_complete(fallback)
  if vim.fn.pumvisible() == 1 then
    vim.api.nvim_feedkeys(utils.t("<C-p>"), "n", true)
  elseif vim.fn["vsnip#jumpable"](-1) == 1 then
    vim.api.nvim_feedkeys(utils.t("<Plug>(vsnip-jump-prev)"), "", true)
  else
    fallback()
  end
end

function plugin.setup()
  local cmp = require("cmp")

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
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
      { name = "nvim_lua" },
      -- { name = "buffer" },
      { name = "calc" },
      { name = "emoji" },
      { name = "treesitter" },
      { name = "spell" },
      { name = "nvim_lua" },
      { name = "vim-dadbod-completion" },
      { name = "vsnip" },

      -- { name = "luasnip" },
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
end

return plugin
