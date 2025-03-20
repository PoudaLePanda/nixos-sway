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
      vscode.enable = true;
      btop.enable = true;
      cava.enable = true;
      gnome.enable = true;
      kitty.enable = true;
      foot.enable = true;
      yazi.enable = true;
      gtk.enable = true;
      ghostty.enable = true;
      gedit.enable = true;
      zed.enable = true;
      # spicetify.enable = true;
      # zathura.enable = true;

      # sway
      dunst.enable = true;
      wofi.enable = true;
      sway.enable = true;
      sway.useWallpaper = true;
      waybar.addCss = true;
      swaylock.enable = true;
      swaylock.useWallpaper = true;
    };
  };
}
