{ pkgs, lib, settings, config, ...}:
let
  details = settings.themeDetails;
  # Générer les couleurs à partir du schéma base16 de Stylix
  stylixColors = config.lib.stylix.colors;
in {
  stylix = {
    enable = true;
    polarity = "dark";
    image = details.wallpaper;
    base16Scheme = lib.mkIf (details.themeName != null) "${pkgs.base16-schemes}/share/themes/${details.themeName}.yaml";
    override = lib.mkIf (details.override != null) details.override;
    targets.qt.platform = "qtct";
    opacity = {
      terminal = details.opacity;
      applications = details.opacity;
      desktop = details.opacity;
      popups = details.opacity;
    };
    targets.gnome.enable = true;
    targets.gtk.enable = true;
    targets.ghostty.enable = true;
    targets.gedit.enable = true;
  };

  # Configuration pour Zed Editor
  xdg.configFile = {
    # Créer le fichier de thème base16 pour Zed
    "zed/themes/stylix-theme.json" = {
      text = builtins.toJSON {
        name = "Stylix-${details.themeName}";
        author = "Generated from Stylix";
        base = {
          # Correspondance entre les couleurs base16 et les attentes de Zed
          background = "#${stylixColors.base00}";
          foreground = "#${stylixColors.base05}";
          accent = "#${stylixColors.base0D}";
          ui = "#${stylixColors.base03}";
          cursor = "#${stylixColors.base05}";
          selection = {
            background = "#${stylixColors.base02}";
            foreground = "#${stylixColors.base07}";
            inactive_background = "#${stylixColors.base01}";
            inactive_foreground = "#${stylixColors.base04}";
          };
          # Définitions pour la coloration syntaxique
          syntax = {
            comment = "#${stylixColors.base03}";
            string = "#${stylixColors.base0B}";
            number = "#${stylixColors.base09}";
            keyword = "#${stylixColors.base0E}";
            function = "#${stylixColors.base0D}";
            constant = "#${stylixColors.base08}";
            type = "#${stylixColors.base0A}";
            variable = "#${stylixColors.base05}";
            attribute = "#${stylixColors.base0C}";
            tag = "#${stylixColors.base08}";
          };
        };
      };
    };
  };
}
