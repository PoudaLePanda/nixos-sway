
{ ... }:
{
  xdg.configFile."zed/settings.json".text = builtins.toJSON {
    auto_update = false;
    telemetry = {
      diagnostics = false;
      metrics = false;
    };
    theme = {
      # System theme switching doesn't seem to work on Linux
      mode = "system";
      dark = "nord";
      light = "nord";
    };
    icon_theme = "Charmed Icons";
    ui_font_size = 16;
    ui_font_family = "Noto Nerd Font";
    font_family = "Noto Nerd Font";
    buffer_font_size = 16;
    features = {
      inline_completion_provider = "none";
    };
    buffer_font_family = "Noto Nerd Font";
    buffer_font_fallbacks = ["Nerd Font"];
    relative_line_numbers = true;
    current_line_highlight = "none";
    vim_mode = false;
    scrollbar.show = "never";
    inlay_hints.enabled = true;
    assistant = {
        default_model = {
            provider = "copilot_chat";
            model = "gpt-4o";
        };
        version = "2";
    };
    terminal = {
      blinking = "on";
      copy_on_select = true;
      font_family = "Noto Nerd Font";
      font_size = 14;
    };
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
    };
    lsp = {
        nil= {
            initialization_options.formatting.command = [ "nixfmt" ];
        };
    };
  };

}
