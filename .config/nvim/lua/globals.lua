CONFIG_PATH = vim.fn.stdpath("config")
DATA_PATH = vim.fn.stdpath("data")
CACHE_PATH = vim.fn.stdpath("cache")

-- For easy debugging
function DD(...) require("snacks.debug").inspect(...) end

function BT(...) require("snacks.debug").backtrace(...) end

function P(...) require("snacks.debug").profile(...) end

function RELOAD(...) return require("plenary.reload").reload_module(...) end

function R(name)
  RELOAD(name)
  return require(name)
end
