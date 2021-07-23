local M = {}

-- Tresitter stuff
local ts_utils = require("nvim-treesitter.ts_utils")
local locals = require("nvim-treesitter.locals")
local utils = require("nvim-treesitter.utils")

-- To draw the window
local window = require("ui.window")

local exec_keys = { n = { "<CR>" }, i = { "<CR>" } }
local quit_keys = { n = { "<Esc>", "<C-c>" }, i = { "<C-c>" } }
local prompt_prefix = "➤ "

local function get_current_name()
  local node_at_point = ts_utils.get_node_at_cursor()

  if not node_at_point then
    utils.print_warning("No variable to rename!")
    return
  end

  local current_name = ts_utils.get_node_text(node_at_point)[1]

  return current_name
end

local function apply_keymaps(bufnr, winnr)
  for mode, keys in pairs(exec_keys) do
    for _, key in ipairs(keys) do
      vim.api.nvim_buf_set_keymap(
        bufnr,
        mode,
        key,
        "<cmd>lua require('ui.rename').do_rename(" .. winnr .. ")<CR>",
        { silent = true, nowait = true }
      )
    end
  end

  for mode, keys in pairs(quit_keys) do
    for _, key in ipairs(keys) do
      vim.api.nvim_buf_set_keymap(
        bufnr,
        mode,
        key,
        "<cmd>lua vim.api.nvim_win_close(" .. winnr .. ", true)<CR>",
        { silent = true, nowait = true }
      )
    end
  end
end

function M.rename()
  local opts = {
    height = 1,
    width = 30,
    border = "rounded",
    enter = true,
  }

  local current_name = get_current_name()

  local bufnr, winnr = window.create_floating_window({}, "", opts)

  local rename_prompt_prefix_ns = vim.api.nvim_create_namespace("ui_rename_prompt_prefix")

  -- Set some options
  vim.api.nvim_buf_set_option(bufnr, "modifiable", true)
  vim.api.nvim_win_set_option(winnr, "scrolloff", 0)
  vim.api.nvim_win_set_option(winnr, "sidescrolloff", 0)
  vim.api.nvim_buf_set_option(bufnr, "buftype", "prompt")

  -- Set the prompt
  vim.fn.prompt_setprompt(bufnr, prompt_prefix)
  vim.api.nvim_buf_add_highlight(bufnr, rename_prompt_prefix_ns, "String", 0, 0, #prompt_prefix)
  -- Write the current name of the variable and select it
  vim.cmd("norm i" .. current_name)
  vim.cmd("norm bve")

  apply_keymaps(bufnr, winnr)
end

local function do_rename_using_lsp(new_name)
  local params = vim.lsp.util.make_position_params()

  params.newName = new_name

  local _, result = pcall(vim.lsp.buf_request, 0, "textDocument/rename", params, nil)

  if result ~= nil then
    return true
  end

  return false
end

local function do_rename_using_treesitter(new_name)
  -- Warn the user
  utils.print_warning("NOTE: using treesitter to rename!")

  local bufnr = vim.api.nvim_get_current_buf()
  local node_at_point = ts_utils.get_node_at_cursor()

  local definition, scope = locals.find_definition(node_at_point, bufnr)
  local nodes_to_rename = {}
  nodes_to_rename[node_at_point:id()] = node_at_point
  nodes_to_rename[definition:id()] = definition

  for _, n in ipairs(locals.find_usages(definition, scope, bufnr)) do
    nodes_to_rename[n:id()] = n
  end

  local edits = {}

  for _, node in pairs(nodes_to_rename) do
    local lsp_range = ts_utils.node_to_lsp_range(node)
    local text_edit = { range = lsp_range, newText = new_name }
    table.insert(edits, text_edit)
  end

  vim.lsp.util.apply_text_edits(edits, bufnr)
end

function M.do_rename(winnr)
  -- Get the new name
  local new_name = vim.trim(vim.fn.getline("."):sub(#prompt_prefix + 1, -1))

  -- Close the window
  vim.api.nvim_win_close(winnr, true)

  -- Get the current name
  local current_name = get_current_name()
  if not (new_name and #new_name > 0) or new_name == current_name then
    return
  end

  -- Check whether a lsp is active or not
  local active = require("lsp.helpers.check_lsp_active")()
  if not active then
    -- Use treesitter to rename if no lsp is active
    do_rename_using_treesitter(new_name)
    return
  end

  -- Come out of insert mode if in it
  vim.cmd("stopinsert")

  -- Try renaming using `lsp`
  if do_rename_using_lsp(new_name) then
    return
  end

  -- Use treesitter to rename if lsp is unable to do so
  do_rename_using_treesitter(new_name)
end

return M
