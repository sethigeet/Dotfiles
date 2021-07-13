local plugin = {}

function plugin.setup()
  vim.g.gitblame_enabled = Opts.plugin.git_blame.enabled and 1 or 0

  vim.g.gitblame_message_template = Opts.plugin.git_blame.config.message_type

  vim.g.gitblame_date_format = Opts.plugin.git_blame.config.date_format

  -- vim.cmd("highlight default link gitblame SpecialComment")
end

function plugin.config()
  Opts.plugin["git_blame"] = {
    enabled = true,
    config = {
      -- Available options for message template
      -- <author>, <committer>, <date>, <committer-date>, <summary>, <sha>
      message_type = "    <summary> • <date> • <author>",

      -- Available options for date format
      -- %a	abbreviated weekday name (e.g., Wed)
      -- %A	full weekday name (e.g., Wednesday)
      -- %b	abbreviated month name (e.g., Sep)
      -- %B	full month name (e.g., September)
      -- %c	date and time (e.g., 09/16/98 23:48:10)
      -- %d	day of the month (16) [01-31]
      -- %H	hour, using a 24-hour clock (23) [00-23]
      -- %I	hour, using a 12-hour clock (11) [01-12]
      -- %M	minute (48) [00-59]
      -- %m	month (09) [01-12]
      -- %p	either "am" or "pm" (pm)
      -- %S	second (10) [00-61]
      -- %w	weekday (3) [0-6 = Sunday-Saturday]
      -- %x	date (e.g., 09/16/98)
      -- %X	time (e.g., 23:48:10)
      -- %Y	full year (1998)
      -- %y	two-digit year (98) [00-99]
      -- %%	the character `%´
      date_format = "%d/%m/%Y",
    },
  }
end

return plugin
