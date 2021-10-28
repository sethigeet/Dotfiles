local utils = require("utils")

local plugin = {}

local function tab_complete(fallback)
  local cmp = require("cmp")

  if cmp.visible() then
    cmp.select_next_item()
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
    cmp.select_prev_item()
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
      ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "s", "c" }),
      ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "s", "c" }),
      ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s", "c" }),
      ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s", "c" }),
      ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i" }),
      ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i" }),
      ["<C-n>"] = cmp.mapping({
        c = function()
          if cmp.visible() then
            cmp.select_next_item()
          else
            vim.api.nvim_feedkeys(utils.t("<Down>"), "n", true)
          end
        end,
        i = function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end,
      }),
      ["<C-p>"] = cmp.mapping({
        c = function()
          if cmp.visible() then
            cmp.select_prev_item()
          else
            vim.api.nvim_feedkeys(utils.t("<Up>"), "n", true)
          end
        end,
        i = function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end,
      }),
      ["<Tab>"] = cmp.mapping({
        c = function()
          if cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
          else
            cmp.complete()
          end
        end,
        i = tab_complete,
        s = tab_complete,
      }),

      ["<S-Tab>"] = cmp.mapping({
        c = function()
          if cmp.visible() then
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
          else
            cmp.complete()
          end
        end,
        i = s_tab_complete,
        s = s_tab_complete,
      }),
      ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
      ["<C-q>"] = cmp.mapping(cmp.mapping.close(), { "i", "s", "c" }),
      ["<C-e>"] = cmp.mapping(cmp.mapping.abort(), { "i", "s", "c" }),
      ["<CR>"] = cmp.mapping({
        i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
        c = function(fallback)
          if cmp.visible() then
            cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
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
      { name = "buffer", opts = { max_completion_items = 15, keyword_length = 5 } },
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
    experimental = {
      ghost_text = true,
    },
  })

  -- Use buffer source for `/`.
  cmp.setup.cmdline("/", {
    sources = {
      { name = "buffer" },
    },
  })

  -- Use cmdline & path source for ':'.
  cmp.setup.cmdline(":", {
    sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
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
      -- NOTE: This is not required as telescope already does it
      -- { "FileType", "TelescopePrompt", "lua require('cmp').setup.buffer({ enabled = false })" },

      -- Turn on some sources in particular filetypes only
      { "FileType", "lua", "lua require('plugins.configs.cmp').append_sources_to_buf({ { name = 'nvim_lua' } })" },
      {
        "FileType",
        "sql,mysql,plsql",
        "lua require('plugins.configs.cmp').append_sources_to_buf({ { name = 'vim-dadbod-completion' } })",
      },
    },
  })
end

return plugin
