local plugin = {}

function plugin.setup()
  vim.g.mkdp_auto_start = false
  vim.g.mkdp_auto_close = true
  vim.g.mkdp_refresh_slow = false
  vim.g.mkdp_command_for_global = false
  vim.g.mkdp_open_to_the_world = false
  vim.g.mkdp_open_ip = ""
  vim.g.mkdp_browser = ""
  vim.g.mkdp_echo_preview_url = true
  vim.g.mkdp_browserfunc = ""
  vim.g.mkdp_preview_options = {
    mkit = {},
    katex = {},
    uml = {},
    maid = {},
    disable_sync_scroll = false,
    sync_scroll_type = "middle",
    hide_yaml_meta = true,
    sequence_diagrams = {},
    flowchart_diagrams = {},
    content_editable = false,
  }
  vim.g.mkdp_markdown_css = ""
  vim.g.mkdp_highlight_css = ""
  vim.g.mkdp_port = "9876"
  vim.g.mkdp_page_title = "${name} - Markdown Preview"
end

return plugin
