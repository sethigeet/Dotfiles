-- WARN: THIS CURRENTLY ONLY SUPPORTS RUST

local M = {}
local define_augroups = require("utils").define_augroups

local opts = {
  -- whether to show parameter hints with the inlay hints or not
  show_parameter_hints = true,

  -- prefix for parameter hints
  parameter_hints_prefix = ": ",

  -- prefix for all the other hints (type, chaining)
  other_hints_prefix = ": ",

  -- The color of the hints
  highlight = "Comment",
}

-- Update inlay hints when opening a new buffer and when writing a buffer to a
-- file
function M.setup_autocmd()
  local events = "BufEnter,BufWinEnter,TabEnter,BufWritePost,TextChanged"

  define_augroups({
    inlay_hints = {
      { events, "<buffer>", "lua require('lsp.helpers.inlay_hints').set_inlay_hints()" },
    },
  })
end

local namespace = vim.api.nvim_create_namespace("rust-analyzer/inlayHints")
-- whether the hints are enabled or not
local enabled = nil

-- parses the result into a easily parsable format
-- example:
-- {
--  ["12"] = { {
--      kind = "TypeHint",
--      label = "String"
--    } },
--  ["13"] = { {
--      kind = "TypeHint",
--      label = "usize"
--    } },
--  ["15"] = { {
--      kind = "ParameterHint",
--      label = "styles"
--    }, {
--      kind = "ParameterHint",
--      label = "len"
--    } },
--  ["7"] = { {
--      kind = "ChainingHint",
--      label = "Result<String, VarError>"
--    }, {
--      kind = "ParameterHint",
--      label = "key"
--    } },
--  ["8"] = { {
--      kind = "ParameterHint",
--      label = "op"
--    } }
-- }
--
local function parseHints(result)
  local map = {}

  if type(result) ~= "table" then
    return {}
  end
  for _, value in pairs(result) do
    local line = tostring(value.range["end"].line)
    local label = value.label
    local kind = value.kind

    local function add_line()
      if map[line] ~= nil then
        table.insert(map[line], { label = label, kind = kind })
      else
        map[line] = { { label = label, kind = kind } }
      end
    end

    add_line()
  end
  return map
end

local function handler(err, result, ctx)
  if err then
    return
  end
  local bufnr = ctx.bufnr

  if vim.api.nvim_get_current_buf() ~= bufnr then
    return
  end

  -- clean it up at first
  M.disable_inlay_hints()

  local ret = parseHints(result)
  local max_len = -1

  for key, _ in pairs(ret) do
    local line = tonumber(key)
    local current_line = vim.api.nvim_buf_get_lines(bufnr, line, line + 1, false)[1]
    if current_line then
      local current_line_len = string.len(current_line)
      max_len = math.max(max_len, current_line_len)
    end
  end

  for key, value in pairs(ret) do
    local virt_text = ""
    local line = tonumber(key)

    local current_line = vim.api.nvim_buf_get_lines(bufnr, line, line + 1, false)[1]

    if current_line then
      local param_hints = {}
      local other_hints = {}

      -- segregate paramter hints and other hints
      for _, value_inner in ipairs(value) do
        if value_inner.kind == "ParameterHint" then
          table.insert(param_hints, value_inner.label)
        else
          table.insert(other_hints, value_inner.label)
        end
      end

      -- show parameter hints inside brackets with commas and a thin arrow
      if not vim.tbl_isempty(param_hints) and opts.show_parameter_hints then
        virt_text = virt_text .. opts.parameter_hints_prefix .. "("
        for i, value_inner_inner in ipairs(param_hints) do
          virt_text = virt_text .. value_inner_inner
          if i ~= #param_hints then
            virt_text = virt_text .. ", "
          end
        end
        virt_text = virt_text .. ") "
      end

      -- show other hints with commas and a thicc arrow
      if not vim.tbl_isempty(other_hints) then
        virt_text = virt_text .. opts.other_hints_prefix
        for i, value_inner_inner in ipairs(other_hints) do
          virt_text = virt_text .. value_inner_inner
          if i ~= #other_hints then
            virt_text = virt_text .. ", "
          end
        end
      end

      -- set the virtual text
      vim.api.nvim_buf_set_extmark(bufnr, namespace, line, 0, {
        virt_text_pos = "eol",
        virt_text = {
          { virt_text, opts.highlight },
        },
        hl_mode = "combine",
      })

      -- update state
      enabled = true
    end
  end
end

function M.toggle_inlay_hints()
  if enabled then
    M.disable_inlay_hints()
  else
    M.set_inlay_hints()
  end
  enabled = not enabled
end

function M.disable_inlay_hints()
  -- clear namespace which clears the virtual text as well
  vim.api.nvim_buf_clear_namespace(0, namespace, 0, -1)
end

-- Sends the request to rust-analyzer to get the inlay hints and handle them
function M.set_inlay_hints()
  vim.lsp.buf_request(
    0,
    "rust-analyzer/inlayHints",
    { textDocument = vim.lsp.util.make_text_document_params() },
    handler
  )
end

return M
