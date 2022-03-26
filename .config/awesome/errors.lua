local spawn = require("awful.spawn")

local function notify(title, msg)
  spawn({
    "notify-send.py",
    "-u",
    "critical",
    "--icon",
    "emblem-important-symbolic",
    "--app-name",
    "AwesomeWM",
    title,
    msg,
  })
end

-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
  notify("Oops, there were errors during startup!", awesome.startup_errors)
end

do
  local in_error = false
  awesome.connect_signal("debug::error", function(err)
    -- Make sure we don't go into an endless error loop
    if in_error then
      return
    end

    in_error = true
    notify("Oops, an error happened!", tostring(err))
    in_error = false
  end)
end
