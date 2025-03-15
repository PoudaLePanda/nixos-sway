
{ pkgs, inputs, ... }:
{
  home.packages = [ pkgs.zed-editor ];

  xdg.configFile."zed/settings.json".source = (pkgs.formats.json { }).generate "settings.json" {
    auto_update = false;
    telemetry = {
      diagnostics = false;
      metrics = false;
    };
    theme = {
      # System theme switching doesn't seem to work on Linux
      mode = "dark";
      dark = "nord";
      light = "nord";
    };
    current_line_highlight = "none";
    vim_mode = false;
    scrollbar.show = "never";
    ui_font_size = 18;
    buffer_font_family = "Noto Nerd Font";
    buffer_font_size = 18;
    inlay_hints.enabled = true;
  };

}