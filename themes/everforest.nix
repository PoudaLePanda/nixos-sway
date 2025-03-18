{ dir }:
{
    themeName = "everforest-dark-hard";
    wallpaper = ../assets/wallpapers/mist_forest_2.png;

    override = null;

    ghosttyTheme = "Everforest Dark - Hard";

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
