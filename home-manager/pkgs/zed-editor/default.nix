# ./host/pkgs/zed-editor/default.nix
{pkgs, ...}:
{
  # imports = [
  #   ./usersettings.nix 
  #   ./userkeymap.nix
  # ];


  programs.zed-editor = {
    enable = false;
    package = pkgs.zed-editor.fhsWithPackages (pkgs: [pkgs.zlib pkgs.openssl]);
    extensions = [
      # langs
      "html"
      "toml"
      "git-firefly"
      "latex"
      "svelte"
      "scss"
      "nix"
      "nu"
      "gosum"
      "scls"

      # misc
      "env"
      "discord-presence"
      "wakatime"

      # themes
      "catppuccin"
      "material-icon-theme"
    ];
  userSettings = {
        assistant = mkIf (cfg.applications.zed.ollamaSupport) {
          default_model = {
            provider = "ollama";
            model = "llama3.1:latest";
          };

          version = 2;
          provider = "null";
        };

        auto_update = false;
        autosave = "off";
        buffer_font_family = "JetBrainsMono Nerd Font";
        buffer_font_size = 14;
        chat_panel.button = false;
        collaboration_panel.button = false;
        features.inline_completion_provider = "none";

        indent_guides = {
          enabled = true;
          coloring = "indent_aware";
        };

        inlay_hints.enabled = true;
        journal.hour_format = "hour24";
        language_models.ollama.api_url = "http://localhost:11434";
        lsp.nil.initialization_options.formatting.command = [ "nixfmt" ];
        notification_panel.button = false;
        relative_line_numbers = true;
        show_whitespaces = "boundary";
        tabs.git_status = true;

        terminal = {
          blinking = "on";
          copy_on_select = true;
          font_family = "JetBrainsMono Nerd Font";
          font_size = 14;
        };

        theme = {
          dark = cfg.applications.zed.theme.dark;
          light = cfg.applications.zed.theme.light;
          mode = cfg.applications.zed.theme.mode;
        };

        ui_font_size = 16;
        vim_mode = cfg.applications.zed.vim;
      };
  };
}