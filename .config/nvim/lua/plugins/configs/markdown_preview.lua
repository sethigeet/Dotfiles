local plugin = {}

function plugin.setup()
  vim.g.mkdp_auto_start = Opts.plugin.markdown_preview.config.auto_start
  vim.g.mkdp_auto_close = Opts.plugin.markdown_preview.config.auto_close
  vim.g.mkdp_refresh_slow = Opts.plugin.markdown_preview.config.refresh_slow
  vim.g.mkdp_command_for_global = Opts.plugin.markdown_preview.config.command_for_global
  vim.g.mkdp_open_to_the_world = Opts.plugin.markdown_preview.config.open_to_the_world
  vim.g.mkdp_open_ip = Opts.plugin.markdown_preview.config.open_ip
  vim.g.mkdp_browser = Opts.plugin.markdown_preview.config.browser
  vim.g.mkdp_echo_preview_url = Opts.plugin.markdown_preview.config.echo_preview_url
  vim.g.mkdp_browserfunc = Opts.plugin.markdown_preview.config.browserfunc
  vim.g.mkdp_preview_options = Opts.plugin.markdown_preview.config.preview_options
  vim.g.mkdp_markdown_css = Opts.plugin.markdown_preview.config.markdown_css
  vim.g.mkdp_highlight_css = Opts.plugin.markdown_preview.config.highlight_css
  vim.g.mkdp_port = Opts.plugin.markdown_preview.config.port
  vim.g.mkdp_page_title = Opts.plugin.markdown_preview.config.page_title
end

function plugin.config()
  Opts.plugin["markdown_preview"] = {
    enabled = true,
    config = {
      auto_start = 0,
      auto_close = 1,
      refresh_slow = 0,
      command_for_global = 0,
      open_to_the_world = 0,
      open_ip = "",
      browser = "",
      echo_preview_url = 1,
      browserfunc = "",
      preview_options = {
        mkit = {},
        katex = {},
        uml = {},
        maid = {},
        disable_sync_scroll = 0,
        sync_scroll_type = "middle",
        hide_yaml_meta = 1,
        sequence_diagrams = {},
        flowchart_diagrams = {},
        content_editable = false,
      },
      markdown_css = "",
      highlight_css = "",
      port = "9876",
      page_title = "${name} - Markdown Preview",
    },
  }
end

return plugin
