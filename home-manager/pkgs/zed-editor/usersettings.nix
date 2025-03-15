_: {
  programs.zed-editor.userSettings = {
    icon_theme = "VSCode Icons (Dark)";
    ui_font_size = 16;
    ui_font_family = "Noto Nerd Font";
    font_family = "Noto Nerd Font";
    buffer_font_size = 16;
    buffer_font_family = "Noto Nerd Font";
    buffer_font_fallbacks = ["Nerd Font"];
    relative_line_numbers = true;
    hour_format = "hour24";
    shell = "nu";
    theme = {
      dark = "Catppuccin Mocha (pink)";
      light = "Catppuccin Mocha (pink)";
    };
    tabs = {
      file_icons = true;
      git_status = true;
    };
    indent_guides = {
      enable = true;
    };
    inlay_hints = {
      enable = true;
    };
    telemetry = {
      diagnostics = false;
      metrics = false;
    };
    assistant = {
      default_model = {
        provider = "copilot_chat";
        model = "gpt-4o";
      };
      version = "2";
    };
    terminal = {
      font_family = "Noto Nerd Font";
    };
    languages = {
      Nix = {
        language_servers = ["nil"];
        formatter = {
          external = {
            command = "alejandra";
            arguments = ["--quiet" "--"];
          };
        };
      };
      lsp = {
      };
    };
  };
}