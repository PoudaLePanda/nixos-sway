{ config, lib, pkgs, ... }:
{
    home.username = "leodev";
    home.homeDirectory = "/home/leodev";

    imports = [
      ./gnome.nix
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
    xdg.configFile."backgrounds/background.jpg".source = ./background.jpg;
    xdg.configFile."avatars/avatar.png".source = ./avatar.png;

    # GTK Configuration (gardez la même que GNOME pour la cohérence)
    gtk = {
        enable = true;
        font = {
            name = "Noto Nerd Font";
            size = 12;
        };
        theme = {
            name = "Colloid-Purple-Dark-Dracula";
            package = pkgs.colloid-gtk-theme.override {
                colorVariants = [ "dark" ];
                themeVariants = [ "purple" ];
                tweaks = [
                    "dracula"
                    "rimless"
                    "float"
                ];
            };
        };
        iconTheme = {
            name = "Reversal-black";
            package = pkgs.reversal-icon-theme.override {
              colorVariants = [ "-black" ];
            };
        };
        cursorTheme = {
            name = "Bibata-Modern-Ice";
            package = pkgs.bibata-cursors;
            size = 24;
        };
    };

    # Cursor settings
    home.pointerCursor = {
        name = "Bibata-Modern-Ice";
        package = pkgs.bibata-cursors;
        size = 24;
    };

    # Polices communes
    home.packages = with pkgs; [
        nerd-fonts.zed-mono
        nerd-fonts.noto
        nerd-fonts.hack
        nerd-fonts.jetbrains-mono
    ];

    home.stateVersion = "24.11"; # Version de compatibilité Home Manager
}
