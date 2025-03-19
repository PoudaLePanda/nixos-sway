{
  lib,
  pkgs,
  settings,
  ...
}: let
  themeDetails = settings.themeDetails;
in {
  imports = lib.optionals (themeDetails.btopTheme != null) [
    (./. + "/${settings.themeAdw}.nix")
  ];

  programs.btop = {
    enable = true;
    package = pkgs.btop.override {rocmSupport = true;};
    settings = {
      color_theme =
        lib.mkIf (themeDetails.btopTheme != null)
        "${themeDetails.btopTheme}.theme";
      theme_background = false;
      vim_keys = true;
      update_ms = 500;
    };
  };
}
