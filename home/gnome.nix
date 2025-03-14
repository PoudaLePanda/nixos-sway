{ config, lib, pkgs, ... }:
{
    # Paquets spécifiques à GNOME
    home.packages = with pkgs; [
        gnome-tweaks
        gnomeExtensions.tiling-shell
        gnomeExtensions.appindicator
        gnomeExtensions.user-themes
        gnomeExtensions.vitals
        gnomeExtensions.caffeine
        gnomeExtensions.dash-to-dock
    ];

    # Configuration GNOME avec dconf
    dconf.settings = {
        "org/gnome/desktop/background" = {
            picture-uri = "file://${config.home.homeDirectory}/.config/backgrounds/background.jpg";
            picture-uri-dark = "file://${config.home.homeDirectory}/.config/backgrounds/background.jpg";
            picture-options = "zoom";
        };
        "org/gnome/desktop/account-photo" = {
            picture-uri = "file://${config.home.homeDirectory}/.config/avatars/avatar.png";
        };
        "org/gnome/shell" = {
            enabled-extensions = [
                "user-theme@gnome-shell-extensions.gcampax.github.com"
                "dash-to-dock@micxgx.gmail.com"
                "caffeine@patapon.info"
                "Vitals@CoreCoding.com"
            ];
        };
        "org/gnome/shell/extensions/dash-to-dock" = {
            dock-position = "BOTTOM";
            dash-max-icon-size = 48;
        };
        "org/gnome/shell/extensions/caffeine" = {
            show-indicator = true;
            auto-enable = true;
        };
        "org/gnome/shell/extensions/vitals" = {
            cpu = true;
            memory = true;
        };
    };
}
