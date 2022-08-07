local utils = require("utils")

local settings = {
  timeout = vim.opt.timeoutlen:get(),
  mapping = { "jk", "kj" },
  keys = "<Esc>",
}

local first_chars = {}
local second_chars = {}

local timer
local waiting = false
local input_states = {}

local function find_indices(tbl, elem)
  local ids = {}
  for i, val in ipairs(tbl) do
    if elem == val then table.insert(ids, i) end
  end
  return ids
end

local function start_timer()
  waiting = true

  if timer then timer:stop() end

  timer = vim.defer_fn(function() waiting = false end, settings.timeout)
end

local function check_timeout()
  if waiting then
    utils.feed("<BS><BS>") -- delete the characters from the mapping
    utils.feed(settings.keys)
    waiting = false -- more timely
    return true
  end
  return false
end

local function check_charaters()
  local char = vim.v.char
  table.insert(input_states, { char = char, modified = vim.bo.modified })

  local matched = false
  if #input_states >= 2 then
    local prev_state = input_states[#input_states - 1]
    local indices = find_indices(second_chars, char)
    for _, idx in ipairs(indices) do
      if first_chars[idx] == prev_state.char then
        matched = check_timeout()
        break
      end
    end

    if matched then
      input_states = {}
      vim.schedule(function() vim.bo.modified = prev_state.modified end)
    end
  end

  -- if can't find a match, and the typed char is first in a mapping, start the timeout
  if not matched and vim.tbl_contains(first_chars, char) then start_timer() end
end

-- Setup:
--   create tables with the first and seconds chars of the mappings
for _, shortcut in ipairs(settings.mapping) do
  vim.cmd("silent! iunmap " .. shortcut)
  table.insert(first_chars, (string.sub(shortcut, 1, 1)))
  table.insert(second_chars, (string.sub(shortcut, 2, 2)))
end

--   create the autocmd
require("utils.wrappers").define_augroups({
  BetterEscape = {
    { "InsertCharPre", "*", cb = check_charaters },
  },
})
