local bufferline = {}

-- Show a shadow over the editor in buffer-pick mode
bufferline.shadow = true

-- Enable/disable icons
bufferline.icons = true

-- Enables/disable clickable tabs
--  - left-click: go to buffer
--  - middle-click: delete buffer
--
-- NOTE disabled by default because this might cause E541 (too many items)
--      if you have many tabs open
bufferline.clickable = true

-- If set, the letters for each buffer in buffer-pick mode will be
-- assigned based on their name. Otherwise or in case all letters are
-- already assigned, the behavior is to assign letters in order of
-- usability
bufferline.semantic_letters = true

-- New buffer letters are assigned in this order. This order is
-- optimal for the qwerty keyboard layout but might need adjustement
-- for other layouts.
bufferline.letters = "asdfjkl;ghnmxcbziowerutyqpASDFJKLGHNMXCBZIOWERUTYQP"

vim.g.bufferline = bufferline
