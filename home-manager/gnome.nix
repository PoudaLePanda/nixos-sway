# ./home/gnome.nix
{ config, pkgs, ... }:
let
  backgroundImage = ../background.png;
in
{
    home.packages = with pkgs; [
        gnome-tweaks
        gnomeExtensions.appindicator
        gnomeExtensions.user-themes
        gnomeExtensions.vitals
        gnomeExtensions.caffeine
        gnomeExtensions.dash-to-dock
        gnomeExtensions.tiling-assistant
    ];

    programs.bash = {
        enable = true;
        initExtra = ''
            eval "$(starship init bash)"
            nerdfetch
        '';
    };

    home.file.".config/backgrounds/background.png".source = backgroundImage;

    dconf.settings = {
        "org/gnome/shell" = {
            "disable-user-extensions" = false;
            enabled-extensions = [
                "user-theme@gnome-shell-extensions.gcampax.github.com"
                "dash-to-dock@micxgx.gmail.com"
                "caffeine@patapon.info"
                "Vitals@CoreCoding.com"
                "tiling-assistant@leleat-on-github"
            ];
            "favorite-apps" = [
                "zen.desktop"
                "dev.zed.Zed.desktop"
                "com.mitchellh.ghostty.desktop"
                "VSCodium.desktop"
                "github-desktop.desktop"
                "steam.desktop"
                "protonvpn-app.desktop"
                "org.gnome.Nautilus.desktop"
            ];
        };

        "org/gnome/desktop/interface" = {
            "color-scheme" = "prefer-dark";
            "enable-animations" = false;
            "enable-hot-corners" = true;
            "font-antialiasing" = "grayscale";
            "font-hinting" = "slight";
            "toolkit-accessibility" = false;
            "gtk-theme" = "Nordic";
            "icon-theme" = "Nordzy";
            "cursor-theme" = "Nordzy-cursors";
            "font-name" = "Noto Nerd Font 12";
        };

        "org/gnome/tweaks" = {
          "show-extensions-notice" = false;
        };

        "org/gtk/gtk4/settings/file-chooser" = {
          "show-hidden" = true;
        };

        "org/gtk/settings/file-chooser" = {
          "date-format" = "regular";
          "location-mode" = "path-bar";
          "show-hidden" = true;
          "show-size-column" = true;
          "show-type-column" = true;
          "sort-column" = "name";
          "sort-directories-first" = true;
          "sort-order" = "ascending";
          "type-format" = "category";
          "view-type" = "list";
        };

        "org/gnome/mutter" = {
            "center-new-windows" = true;
            "dynamic-workspaces" = true;
            "edge-tiling" = true;
        };

        "org/gnome/nautilus/preferences" = {
            "default-folder-viewer" = "list-view";
            "migrated-gtk-settings" = true;
            "search-filter-time-type" = "last_modified";
            "search-view" = "list-view";
        };

        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
          "binding" = "<Control>space";
          "command" = "ulauncher-toggle";
          "name" = "Ulauncher";
        };

        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3" = {
            "binding" = "<Shift><Super>t";
            "command" = "ghostty";
            "name" = "Ghostty";
        };

        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom5" = {
            "binding" = "<Shift><Super>f";
            "command" = "nautilus";
            "name" = "Files";
        };

        "org/gnome/desktop/background" = {
          "picture-uri" = "file://${config.home.homeDirectory}/.config/backgrounds/background.png";
          "picture-uri-dark" = "file://${config.home.homeDirectory}/.config/backgrounds/background.png";
          "picture-options" = "zoom";
        };

        "org/gnome/shell/extensions/user-theme" = {
          "name" = "Graphite-teal-Dark-nord";
        };

        "org/gnome/shell/extensions/dash-to-dock" = {
            dock-position = "BOTTOM";
            dash-max-icon-size = 48;
        };

        "org/gnome/shell/extensions/caffeine" = {
            show-indicator = true;
            auto-enable = true;

        };

        "org/gnome/shell/extensions/tiling-assistant" = {
            "window-gap" = 15;
            "enable-tiling-popup" = false;
            "enable-tile-animations" = false;
            "tiling-popup-all-workspace" = true;
            "active-window-hint" = true;
            "active-window-hint-color" = "rgba(53, 132, 228, 0.3)";
            "enable-dynamic-keybinding-workspace" = true;
        };

        "org/gnome/shell/extensions/vitals" = {
            cpu = true;
            memory = true;
        };
    };
}
