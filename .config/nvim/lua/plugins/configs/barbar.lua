local bufferline = {}

-- Show a shadow over the editor in buffer-pick mode
bufferline.shadow = "v:true"

-- Enable/disable icons
bufferline.icons = "v:true"

-- Enables/disable clickable tabs
--  - left-click: go to buffer
--  - middle-click: delete buffer
--
-- NOTE disabled by default because this might cause E541 (too many items)
--      if you have many tabs open
bufferline.clickable = "v:true"

-- If set, the letters for each buffer in buffer-pick mode will be
-- assigned based on their name. Otherwise or in case all letters are
-- already assigned, the behavior is to assign letters in order of
-- usability (see order below)
bufferline.semantic_letters = "v:true"

-- New buffer letters are assigned in this order. This order is
-- optimal for the qwerty keyboard layout but might need adjustement
-- for other layouts.
bufferline.letters = "asdfjkl;ghnmxcbziowerutyqpASDFJKLGHNMXCBZIOWERUTYQP"

vim.g.bufferline = bufferline

local bg_current = vim.fn.get(vim.api.nvim_get_hl_by_name("Normal", 1),
                              "background", "#000000")
local bg_visible = vim.fn.get(vim.api.nvim_get_hl_by_name("TabLineSel", 1),
                              "background", "#000000")
local bg_inactive = vim.fn.get(vim.api.nvim_get_hl_by_name("TabLine", 1),
                               "background", "#000000")

-- For the current active buffer
vim.cmd("hi default link BufferCurrent      Normal")
-- For the current active buffer when modified
vim.cmd("hi default link BufferCurrentMod   Normal")
-- For the current active buffer icon
vim.cmd("hi default link BufferCurrentSign  Normal")
-- For the current active buffer target when buffer-picking
vim.cmd("exe 'hi default BufferCurrentTarget guifg=red gui=bold guibg=" ..
            bg_current .. "'")

-- For buffers visible but not the current one
vim.cmd("hi default link BufferVisible      TabLineSel")
vim.cmd("hi default link BufferVisibleMod   TabLineSel")
vim.cmd("hi default link BufferVisibleSign  TabLineSel")
vim.cmd("exe 'hi default BufferVisibleTarget guifg=red gui=bold guibg=" ..
            bg_visible .. "'")

-- For buffers invisible buffers
vim.cmd("hi default link BufferInactive     TabLine")
vim.cmd("hi default link BufferInactiveMod  TabLine")
vim.cmd("hi default link BufferInactiveSign TabLine")
vim.cmd("exe 'hi default BufferInactiveTarget guifg=red gui=bold guibg=" ..
            bg_inactive .. "'")

-- For the shadow in buffer-picking mode
vim.cmd("hi default BufferShadow guifg=#000000 guibg=#000000")
