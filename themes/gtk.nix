{
  pkgs,
  lib,
  settings,
  ...
}: {
  gtk = {
    enable = true;

    theme = {
      name = lib.mkForce "adw-gtk3";
      package = lib.mkForce pkgs.adw-gtk3;
    };

    cursorTheme = let
      cursorTheme =
        if settings.themeAdw == "nord"
        then {
          name = "Capitaine Cursors (Nord)";
          package = pkgs.capitaine-cursors-themed;
        }
        else if settings.themeAdw == "dracula"
        then {
          name = "Dracula-cursors";
          package = pkgs.dracula-theme;
        }
        else if settings.themeAdw == "kanagawa"
        then {
          name = "Capitaine Cursors (Gruvbox)";
          package = pkgs.capitaine-cursors-themed;
        }
        else if settings.themeAdw == "catppuccin"
        then {
          name = "Breeze_Snow";
          package = pkgs.catppuccin-cursors;
        }
        else if settings.themeAdw == "everforest"
        then {
          name = "Capitaine Cursors";
          package = pkgs.capitaine-cursors-themed;
        }
        else if settings.themeAdw == "gruvbox"
        then {
          name = "Capitaine Cursors (Gruvbox)";
          package = pkgs.capitaine-cursors-themed;
        }
        else {
          name = "Adwaita";
          package = pkgs.gnome.adwaita-icon-theme;
        };
    in {
      inherit (cursorTheme) name package;
      size = 24;
    };

    iconTheme = let
      iconTheme =
        if settings.themeAdw == "nord"
        then {
          name = "Nordzy";
          package = pkgs.nordzy-icon-theme;
        }
        else if settings.themeAdw == "dracula"
        then {
          name = "Dracula";
          package = pkgs.dracula-icon-theme;
        }
        else if settings.themeAdw == "kanagawa"
        then {
          name = "Kanagawa";
          package = pkgs.kanagawa-icon-theme;
        }
        else if settings.themeAdw == "catppuccin"
        then {
          name = "Reversal";
          package = pkgs.reversal-icon-theme;
        }
        else if settings.themeAdw == "everforest"
        then {
          name = "Gruvbox-Plus-Dark";
          package = pkgs.gruvbox-plus-icons;
        }
        else if settings.themeAdw == "gruvbox"
        then {
          name = "Gruvbox-Plus-Dark";
          package = pkgs.gruvbox-plus-icons;
        }
        else {
          name = "Adwaita";
          package = pkgs.gnome.adwaita-icon-theme;
        };
    in {
      inherit (iconTheme) name package;
    };
  };
}
