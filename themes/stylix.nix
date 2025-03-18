{
  pkgs,
  lib,
  settings,
  ...
}: let
  details = settings.themeDetails;
in {
  stylix = {
    enable = true;
    polarity = "dark";
    image = details.wallpaper;
    base16Scheme = lib.mkIf (details.themeName != null) "${pkgs.base16-schemes}/share/themes/${details.themeName}.yaml";
    override = lib.mkIf (details.override != null) details.override;
    targets.qt.platform = "kde";

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
    targets.zed-editor.enable = true;
  };
}
