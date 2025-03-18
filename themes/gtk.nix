{ pkgs, lib, settings, ... }:
{
  # Return cursor & icon by theme
  home.pointerCursor = let
    cursorTheme = if settings.themeAdw == "nord" then {
      name = "Captaine Cursors (Nord)";
      package = pkgs.capitaine-cursors-themed;
    } else if settings.themeAdw == "dracula" then {
      name = "Dracula-cursors";
      package = pkgs.dracula-theme;
    } else if settings.themeAdw == "kanagawa" then {
      name = "Captaine Cursors (Gruvbox)";
      package = pkgs.capitaine-cursors-themed;
    } else if settings.themeAdw == "catppuccin" then {
      name = "Catppuccin cursors mocha";
      package = pkgs.catppuccin-cursors;
    } else if settings.themeAdw == "everforest" then {
      name = "Captaine Cursors";
      package = pkgs.capitaine-cursors-themed;
    } else if settings.themeAdw == "gruvbox" then {
      name = "Captaine Cursors (Gruvbox)";
      package = pkgs.capitaine-cursors-themed;
    } else {
      name = "Adwaita";
      package = pkgs.gnome.adwaita-icon-theme;
    };
  in {
    inherit (cursorTheme) name package;
    size = 24;
    gtk.enable = true;
  };

  home.gtk = {
    iconTheme = let
      iconTheme = if settings.themeAdw == "nord" then {
        name = "Nordzy";
        package = pkgs.nordzy-icon-theme;
      } else if settings.themeAdw == "dracula" then {
        name = "Dracula";
        package = pkgs.dracula-icon-theme;
      } else if settings.themeAdw == "kanagawa" then {
        name = "Kanagawa";
        package = pkgs.kanagawa-icon-theme;
      } else if settings.themeAdw == "catppuccin" then {
        name = "Reversal";
        package = pkgs.reversal-icon-theme;
      } else if settings.themeAdw == "everforest" then {
        name = "Gruvbox Dark";
        package = pkgs.gruvbox-plus-icons;
      } else if settings.themeAdw == "gruvbox" then {
        name = "Gruvbox Dark";
        package = pkgs.gruvbox-plus-icons;
      } else {
        name = "Adwaita";
        package = pkgs.gnome.adwaita-icon-theme;
      };
    in {
      inherit (iconTheme) name package;
    };
  };
}
