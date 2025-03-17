
{ settings, ... }:
{
  xdg.configFile."zed/settings.json" = {

    text = builtins.toJSON {
    auto_update = false;
    telemetry = {
      diagnostics = false;
      metrics = false;
    };
    icon_theme = "Charmed Icons";
    ui_font_size = 16;
    ui_font_family = settings.font;
    font_family = settings.font;
    buffer_font_size = 14;
    buffer_font_family = settings.font;
    buffer_font_fallbacks = ["Nerd Font"];
    relative_line_numbers = true;
    current_line_highlight = "none";
    vim_mode = false;
    scrollbar.show = "never";
    inlay_hints.enabled = true;
    terminal = {
      blinking = "on";
      copy_on_select = true;
      font_family = settings.font;
      font_size = settings.fontSize;
    };
    soft_wrap = "preferred_line_length";
    preferred_line_length= 120;
    show_wrap_guides = true;
    tab_size = 2;
    show_edit_predictions = true;
    show_completions_on_input = true;
    languages = {
        Nix = {
            language_servers = ["nixd"];
            formatter = {
                external = {
                    command = "alejandra";
                    arguments = ["--quiet" "--"];
                };
            };
        };
        JavaScript= {
          tab_size= 2;
          formatter= {
            external= {
              command= "prettier";
              arguments= ["--stdin-filepath" "{buffer_path}"];
            };
          };
        };
    };
    lsp = {
        nil= {
            initialization_options.formatting.command = [ "nixfmt" ];
        };
    };
  };

  onChange = ''
    if [ -f "$HOME/.config/zed/settings.json" ]; then
      chmod u+w "$HOME/.config/zed/settings.json"
    fi
  '';
  };
}
