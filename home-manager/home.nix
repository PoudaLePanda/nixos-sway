# ./home/home.nix
{ pkgs, inputs, ... }:
{
    home.username = "lmlab";
    home.homeDirectory = "/home/lmlab";

    imports = [
      ./pkgs/fastfetch/default.nix
      ./pkgs/starship/default.nix
      ./pkgs/zed-editor/default.nix
      ./ulauncher/default.nix
      ./wallpaper/default.nix
      ./gnome.nix
    ];


    home.packages = with pkgs; [
        nerd-fonts.zed-mono
        nerd-fonts.noto
        nerd-fonts.hack
        nerd-fonts.jetbrains-mono
        nordic
        nordzy-icon-theme
        nordzy-cursor-theme
        (pkgs.graphite-gtk-theme.override {
            themeVariants = ["teal"];
            tweaks = ["float" "colorful" "nord" "rimless"];
        })
    ];

    # basic configuration of git, please change to your own
    programs.git = {
        enable = true;
        userName = "PoudaLePanda";
        userEmail = "leo.meyniel@proton.me";
        extraConfig = {
            init.defaultBranch = "main";
        };
    };

    # Configuration XDG
    xdg.enable = true;

    # GTK Configuration (gardez la même que GNOME pour la cohérence)
    gtk = {
        enable = true;
        font = {
            name = "Noto Nerd Font";
            size = 12;
        };
        iconTheme = {
            name = "Nordzy";
        };
        cursorTheme = {
            name = "Nordzy-cursors";
            size = 24;
        };
        theme = {
            name = "Nordic";
        };
    };

    # Cursor settings
    home.pointerCursor = {
        name = "Nordzy-cursors";
        size = 24;
        package = pkgs.nordzy-cursor-theme;
    };

    home.stateVersion = "24.11"; # Version de compatibilité Home Manager
}
