{ dir, settings }:
{
    themeName = "nord";
    wallpaper = ../assets/wallpapers/wave.png;

    cursor = {
        size = 32;
        name = settings.cursor;
        package = settings.cursorPkg;
    };

    override = {
        base02 = "#445060";
        base05 = "#fffcf0";
    };

    # Override stylix theme of btop.
    btopTheme = "nord";
    ghosttyTheme = "nord";

    # Hyprland and ags;
    opacity = 1.0;
    rounding = 25;
    shadow = true;
    bordersPlusPlus = false;
    ags = {
        theme = {
            palette = {};
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
