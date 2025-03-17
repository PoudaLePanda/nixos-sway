{ dir, settings, pkgs }:
{
    themeName = "everforest-dark-hard";
    wallpaper = ../assets/wallpapers/mist_forest_2.png;

    # cursor = {
    #   size = 32;
    #   name = "Captaine Cursors";
    #   package = pkgs.capitaine-cursors-themed;
    # };

    override = null;
    # Override stylix theme of btop.
    btopTheme = null;

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
