# ./home/gnome.nix
{ config, pkgs, ... }:
{
    # Paquets spécifiques à GNOME
    home.packages = with pkgs; [
        gnome-tweaks
        gnomeExtensions.appindicator
        gnomeExtensions.user-themes
        gnomeExtensions.vitals
        gnomeExtensions.caffeine
        gnomeExtensions.dash-to-dock
    ];

    programs.bash = {
        enable = true;

        # Ajout des commandes à la fin du fichier bashrc
        initExtra = ''
        # Initialisation de starship
        eval "$(starship init bash)"

        # Exécution de fastfetch au démarrage
        fastfetch
        '';
    };
    # Configuration GNOME avec dconf
    dconf.settings = {
        "org/gnome/desktop/interface" = {
            "color-scheme" = "prefer-dark";
            "enable-animations" = false;
            "enable-hot-corners" = true;
            "font-antialiasing" = "grayscale";
            "font-hinting" = "slight";
            "toolkit-accessibility" = false;
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
            picture-uri = "file://${config.home.homeDirectory}/.config/backgrounds/background.jpg";
            picture-uri-dark = "file://${config.home.homeDirectory}/.config/backgrounds/background.jpg";
            picture-options = "zoom";
        };

        "org/gnome/shell" = {
            "disable-user-extensions" = false;
            enabled-extensions = [
                "user-theme@gnome-shell-extensions.gcampax.github.com"
                "dash-to-dock@micxgx.gmail.com"
                "caffeine@patapon.info"
                "Vitals@CoreCoding.com"
            ];
            "favorite-apps" = [
              "zen.desktop"
              "zed-editor.desktop"
              "Ghostty.desktop"
              "org.gnome.Nautilus.desktop"
            ];
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

        "org/gnome/shell/extensions/vitals" = {
            cpu = true;
            memory = true;
        };
    };
}
