{dir, ...}: {
  themeName = "kanagawa";
  wallpaper = ../assets/wallpapers/kanagawa.jpg;

  # Stylix palette override.
  override = null;

  zedTheme = "Base16 Kanagawa";
  ghosttyTheme = "Base16 Kanagawa";

  # Hyprland and ags;
  opacity = 1.0;
  rounding = 25;
  shadow = true;
  bordersPlusPlus = true;
  ags = {
    theme = {
      palette = {
        widget = "#45403d";
      };
      border = {
        width = 1;
        opacity = 96;
      };
    };
    bar = {
      curved = true;
    };
    widget = {
      opacity = 0;
    };
  };
}
