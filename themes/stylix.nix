{
  inputs,
  pkgs,
  lib,
  settings,
  config,
  ...
}: let
  themeDetails = settings.themeDetails;
in {
  stylix = {
    enable = true;
    polarity = "dark";
    image = themeDetails.wallpaper;
    base16Scheme = lib.mkIf (themeDetails.themeName != null) "${pkgs.base16-schemes}/share/themes/${themeDetails.themeName}.yaml";
    override = lib.mkIf (themeDetails.override != null) themeDetails.override;
    opacity = {
      terminal = themeDetails.opacity;
      applications = themeDetails.opacity;
      desktop = themeDetails.opacity;
      popups = themeDetails.opacity;
    };
    targets = {
      qt.platform = "qtct";
      gnome.enable = true;
      gtk.enable = true;
      ghostty.enable = true;
      gedit.enable = true;
      zed.enable = true;
      spicetify.enable = false;
      zathura.enable = false;
    };
  };
}
