{ config, lib, pkgs, ... }:
{
    # Paquets spécifiques à GNOME
    home.packages = with pkgs; [
        gnome-tweaks
        gnomeExtensions.tiling-shell
        gnomeExtensions.appindicator
        gnomeExtensions.user-themes
        gnomeExtensions.vitals
        gnomeExtensions.pop-shell
        gnomeExtensions.rounded-window-corners-reborn
        gnomeExtensions.caffeine
        gnomeExtensions.dash-to-dock
    ];

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
            "binding" = "<Shift><Super>Return";
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

        "org/gnome/desktop/account-photo" = {
            picture-uri = "file://${config.home.homeDirectory}/.config/avatars/avatar.png";
        };

        "org/gnome/shell" = {
            "disable-user-extensions" = false;
            enabled-extensions = [
                "user-theme@gnome-shell-extensions.gcampax.github.com"
                "pop-shell@system76.com"
                "rounded-window-corners@fxgn"
                "dash-to-dock@micxgx.gmail.com"
                "caffeine@patapon.info"
                "Vitals@CoreCoding.com"
            ];
            "favorite-apps" = [
              "org.gnome.Nautilus.desktop"
              "zen-browser.desktop"
              "ghostty.desktop"
              "zed.desktop"
            ];
        };

        "org/gnome/shell/extensions/pop-shell" = {
          "active-hint" = false;
          "gap-inner" = mkUint32 1;
          "gap-outer" = mkUint32 1;
          "tile-by-default" = true;
        };

        "org/gnome/shell/extensions/dash-to-dock" = {
            dock-position = "BOTTOM";
            dash-max-icon-size = 48;
        };

        "org/gnome/shell/extensions/rounded-window-corners-reborn" = {
            "blacklist" = ["ulauncher"];
            "border-color" = mkTuple [0.71764707565307617 0.74117660522460938 0.97254902124404907 1.0];
            "border-width" = 1;
            global-rounded-corner-settings = [
            (mkDictionaryEntry [
                "padding"
                (mkVariant [
                (mkDictionaryEntry ["left" (mkVariant 1)])
                (mkDictionaryEntry ["right" (mkVariant 1)])
                (mkDictionaryEntry ["top" (mkVariant 1)])
                (mkDictionaryEntry ["bottom" (mkVariant 1)])
                ])
            ])

            (mkDictionaryEntry [
                "keepRoundedCorners"
                (mkVariant [
                (mkDictionaryEntry ["maximized" (mkVariant true)])
                (mkDictionaryEntry ["fullscreen" (mkVariant false)])
                ])
            ])

            (mkDictionaryEntry ["borderRadius" (mkVariant 8)])
            (mkDictionaryEntry ["smoothing" (mkVariant 0)])
            (mkDictionaryEntry ["enabled" (mkVariant true)])
            ];
            "settings-version" = mkUint32 6;
            "skip-libadwaita-app" = false;
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

      # pop-shell settings
      xdg.configFile = {
        "pop-shell/config.json".text = ''
          {
            "float": [
              {
                "class": "ulauncher"
              },
              {
                "class": "org.gnome.Calculator"
              }
            ],
            "skiptaskbarhidden": [],
            "log_on_focus": false
          }
        '';
      };
}
