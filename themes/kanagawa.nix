{ dir }:
{
    themeName = "kanagawa";
    wallpaper = ../assets/wallpapers/kanagawa.jpg;

    override = null;

    ghosttyTheme = "Kanagawa Dragon";

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
