local utils = require("utils")

local plugin = {}

function plugin.setup()
  require("compe").setup({
    enabled = true,
    autocomplete = true,
    debug = false,
    min_length = 1,
    preselect = "enable",
    throttle_time = 80,
    source_timeout = 200,
    incomplete_delay = 400,
    allow_prefix_unmatch = false,
    max_abbr_width = 1000,
    max_kind_width = 1000,
    max_menu_width = 1000000,
    documentation = true,

    source = {
      path = { kind = "  " },
      buffer = { kind = "  " },
      calc = { kind = "  " },
      vsnip = { kind = "  " },
      nvim_lsp = { kind = "  " },
      nvim_lua = { kind = "  " },
      spell = { kind = "  " },
      tags = false,
      snippets_nvim = { kind = "  " },
      treesitter = { kind = "  " },
      emoji = { kind = " ﲃ " },
    },
  })

  -- Dadbod completion
  vim.g["compe.source.vim_dadbod_completion"] = true

  plugin.keymaps()
end

local function tabComplete()
  if vim.fn.pumvisible() == 1 then
    return utils.t("<C-n>")
  elseif vim.fn.call("vsnip#available", { 1 }) == 1 then
    return utils.t("<Plug>(vsnip-expand-or-jump)")
  elseif utils.checkBackSpace() then
    return utils.t("<Tab>")
  else
    return vim.fn["emmet#expandAbbrIntelligent"]("\\<Tab>")
  end
end

local function sTabComplete()
  if vim.fn.pumvisible() == 1 then
    return utils.t("<C-p>")
  elseif vim.fn.call("vsnip#jumpable", { -1 }) == 1 then
    return utils.t("<Plug>(vsnip-jump-prev)")
  else
    return utils.t("<S-Tab>")
  end
end

function plugin.keymaps()
  local map = require("utils.map")

  map.imap("<Tab>", tabComplete, { expr = true })
  map.smap("<Tab>", tabComplete, { expr = true })
  map.imap("<S-Tab>", sTabComplete, { expr = true })
  map.smap("<S-Tab>", sTabComplete, { expr = true })
  map.imap("<C-Space>", "compe#complete()", { expr = true })
  map.imap("<C-e>", "compe#close('<C-e>')", { expr = true })
end

return plugin
