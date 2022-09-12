local M = {}

local highlighter = require("vim.treesitter.highlighter")
local ts_utils = require("nvim-treesitter.ts_utils")
local theme_utils = require("tokyonight.util")

local UNUSED_DIAGS = { "never read", "unused" }

local function string_contains_any(str, substrs)
  for _, substr in ipairs(substrs) do
    if string.match(string.lower(str), substr) then return true end
  end

  return false
end

local function get_treesitter_hl(row, col)
  local buf = vim.api.nvim_get_current_buf()

  local self = highlighter.active[buf]
  if not self then return {} end

  local matches = {}

  self.tree:for_each_tree(function(tstree, tree)
    if not tstree then return end

    local root = tstree:root()
    local root_start_row, _, root_end_row, _ = root:range()

    if root_start_row > row or root_end_row < row then return end

    local query = self:get_query(tree:lang())

    if not query:query() then return end

    local iter = query:query():iter_captures(root, self.bufnr, row, row + 1)

    for capture, node, _ in iter do
      local hl = query.hl_cache[capture]

      if hl and ts_utils.is_in_node_range(node, row, col) then
        local c = query._query.captures[capture] -- name of the capture in the query
        if c ~= nil then
          local general_hl = query:_get_hl_from_capture(capture)
          table.insert(matches, general_hl)
        end
      end
    end
  end, true)
  return matches
end

local function highlight_word(ns, line, from, to)
  local ts_hi = get_treesitter_hl(line, from)
  local final = #ts_hi >= 1 and ts_hi[#ts_hi]
  if type(final) ~= "string" then final = "Normal" end
  local hl = vim.api.nvim_get_hl_by_name(final, true)
  local color = string.format("#%x", hl["foreground"] or 0)
  if #color ~= 7 then color = "#ffffff" end
  vim.api.nvim_set_hl(
    0,
    string.format("%sDimmed", final),
    { fg = theme_utils.darken(color, 0.75), undercurl = false, underline = false }
  )
  vim.api.nvim_buf_add_highlight(0, ns, string.format("%sDimmed", final), line, from, to)
end

function M.highlight_unused()
  vim.api.nvim_set_hl_ns(M.ns)

  local lsp_data = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
  vim.api.nvim_buf_clear_namespace(0, M.ns, 0, -1)

  for _, lsp_datum in ipairs(lsp_data) do
    if string_contains_any(lsp_datum.user_data.lsp.code, UNUSED_DIAGS) then
      highlight_word(M.ns, lsp_datum.lnum, lsp_datum.col, lsp_datum.end_col)
    end
  end
end

function M.setup()
  M.ns = vim.api.nvim_create_namespace("lsp_dim_unused")

  M.highlight_unused()

  require("utils.wrappers").define_augroups({
    dim_unused = {
      { "TextChanged", "<buffer>", cb = M.highlight_unused },
      { "InsertLeave", "<buffer>", cb = M.highlight_unused },
    },
  })
end

return M
