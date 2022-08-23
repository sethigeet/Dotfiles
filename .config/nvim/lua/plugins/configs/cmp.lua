local utils = require("utils")
local Plugin = require("plugins.plugin")

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

return Plugin:create({
  configure = function()
    local cmp = require("cmp")

    cmp.setup({
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
        documentation = cmp.config.window.bordered({
          border = "rounded",
          winhighlight = "FloatBorder:FloatBorder",
        }),
        -- completion = cmp.config.window.bordered(),
      },
      view = {
        entries = "custom",
      },
      formatting = {
        format = function(_, vim_item)
          local icons = require("lsp.kind")
          vim_item.kind = " " .. icons[vim_item.kind] .. " "
          return vim_item
        end,
      },
      experimental = {
        ghost_text = true,
      },
    })
  end,

  augroups = {
    cmp_custom = {
      -- NOTE: This is not required as telescope already does it
      -- { "FileType", "TelescopePrompt", "lua require('cmp').setup.buffer({ enabled = false })" },

      -- Turn on some sources in particular filetypes only
      {
        "FileType",
        "lua",
        cb = function() require("plugins.configs.cmp").utils.append_sources_to_buf({ { name = "nvim_lua" } }) end,
      },
    },
  },

  utils = {
    append_sources_to_buf = function(sources)
      local config = require("cmp.config")
      local temp_sources = vim.deepcopy(config.global.sources)
      for _, source in ipairs(sources) do
        table.insert(temp_sources, source)
      end

      require("cmp").setup.buffer({ sources = temp_sources })
    end,
  },
})
