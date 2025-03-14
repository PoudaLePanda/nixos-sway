# ./home/gnome.nix
{ config, lib, pkgs, ... }:
let
  # Import des fonctions nécessaires pour dconf
  inherit (lib.hm.gvariant) mkUint32 mkVariant mkDictionaryEntry;
in
{
    # Paquets spécifiques à GNOME
    home.packages = with pkgs; [
        gnome-tweaks
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

        # "org/gnome/desktop/account-photo" = {
        #   picture-uri = "file://${config.home.homeDirectory}/.config/avatars/${../avatar.png}";
        # };

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
              "Zen-Browser.desktop"
              "Ghostty.desktop"
              "Zed.desktop"
              "org.gnome.Nautilus.desktop"
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
            "border-color" = "#4F057D";
            "border-width" = 1;
            global-rounded-corner-settings = [
            (mkDictionaryEntry [
                "padding"
                (mkVariant [
                (mkDictionaryEntry ["left" (mkVariant 5)])
                (mkDictionaryEntry ["right" (mkVariant 5)])
                (mkDictionaryEntry ["top" (mkVariant 5)])
                (mkDictionaryEntry ["bottom" (mkVariant 5)])
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
            "keepRoundedCornersForMaximized" = true;
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
