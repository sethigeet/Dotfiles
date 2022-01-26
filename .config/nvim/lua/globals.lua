CONFIG_PATH = vim.fn.stdpath("config")
DATA_PATH = vim.fn.stdpath("data")
CACHE_PATH = vim.fn.stdpath("cache")

-- For easy debugging
function P(v)
  print(vim.inspect(v))
  return v
end

function RELOAD(...)
  return require("plenary.reload").reload_module(...)
end

function R(name)
  RELOAD(name)
  return require(name)
end
