{dir, ...}: {
  themeName = "everforest-dark-hard";
  wallpaper = ../assets/wallpapers/gruvbox-uw.png;

  # Stylix palette override.
  override = null;

  # Hyprland and ags;
  opacity = 1.0;
  rounding = 0;
  shadow = true;
  bordersPlusPlus = true;
  ags = {
    theme = {
      border = {
        width = 1;
        opacity = 70;
      };
    };
    bar = {
      flatButtons = true;
    };
  };
}
