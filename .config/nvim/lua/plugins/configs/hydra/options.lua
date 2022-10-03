local Hydra = require("hydra")

local function ifttt(key, val1, val2)
  return function()
    if vim.o[key] == val1 then
      vim.o[key] = val2
    else
      vim.o[key] = val1
    end
  end
end

local function cmd(c, isPlugin)
  local prefix = isPlugin and "<Plug>" or "<Cmd>"
  local suffix = isPlugin and "" or "<CR>"
  return prefix .. c .. suffix
end

local function get_icon_fn(key)
  return function()
    if vim.o[key] then return "﫟" end

    return " "
  end
end

local function get_icon_cb_fn(cb)
  return function()
    if cb() then return "﫟" end

    return " "
  end
end

local options_menu_args = {
  name = "Options",
  hint = [[
  ^ ^       漣Options
  ^
  _c_ %{cul}cursor line
  _i_ %{list}invisible characters
  _n_ %{nu}number
  _r_ %{rnu}relative number
  _s_ %{spell}spell
  _v_ %{ve}virtual edit
  _w_ %{wrap}wrap

  _z_ %{zen}zen mode
  $mkdp
  ^
       ^^^^                _<Esc>_  
]],
  config = {
    color = "amaranth",
    hint = {
      border = "rounded",
      position = "middle",
    },
  },
  mode = { "n" },
  heads = {
    { "c", ifttt("cursorline", true, false) },
    { "i", ifttt("list", true, false) },
    { "n", ifttt("number", true, false) },
    { "r", ifttt("relativenumber", true, false) },
    { "s", ifttt("spell", true, false) },
    { "v", ifttt("virtualedit", "all", "block") },
    { "w", ifttt("wrap", true, false) },
    { "z", cmd("ZenMode"), { exit = true } },
    { "<Esc>", nil, { exit = true } },
  },
}

local options = {
  list = "list",
  spell = "spell",
  wrap = "wrap",
  cul = "cursorline",
  nu = "number",
  rnu = "relativenumber",
}

return {
  init = function()
    local vim_options = require("hydra.hint.vim-options")
    vim_options.ve = get_icon_cb_fn(function() return vim.tbl_contains(vim.opt.virtualedit:get(), "all") end)
    vim_options.mkdp = get_icon_cb_fn(function() return vim.b.MarkdownPreviewToggleBool == 1 end)
    vim_options.zen = get_icon_cb_fn(function() return require("zen-mode.view").is_open() end)
    for i, j in pairs(options) do
      vim_options[i] = get_icon_fn(j)
    end
  end,

  menu = function()
    local mkdp_placeholder = ""
    if vim.o.filetype == "markdown" or vim.o.filetype == "markdownreact" then
      mkdp_placeholder = "_M_ %{mkdp}Markdown Preview"
      table.insert(options_menu_args.heads, { "M", cmd("MarkdownPreviewToggle"), { exit = true } })
    end
    options_menu_args.hint = options_menu_args.hint:gsub("%$(%w+)", { mkdp = mkdp_placeholder })
    Hydra(options_menu_args):activate()
  end,
}
