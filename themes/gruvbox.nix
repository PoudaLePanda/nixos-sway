{ dir }:
{
    themeName = "gruvbox-material-dark-medium";
    wallpaper = ../assets/wallpapers/gruvbox.png;

    cursor = {
        size = 32;
        name = "Captaine Cursors (Gruvbox)";
    #     package = pkgs.capitaine-cursors-themed;
    };

    override = null;

    # Override stylix theme of btop.
    btopTheme = "gruvbox_dark_v2";

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
