# ./home/home.nix
{ config, inputs, lib, pkgs, settings, ... }:
{
    home.sessionVariables = {
        HOME_MANAGER_CONFIG = "$HOME/DOTFILES/home-manager/home.nix";
    };

    home = {
        username = settings.username;
        homeDirectory = "/home/${settings.username}";
        activation = {
            createDirectories = ''
                $DRY_RUN_CMD mkdir -p $VERBOSE_ARG \
                $HOME/DEV \
            '';
        };
        file.".config/gtk-3.0/bookmarks".force = true;
        file.".config/gtk-3.0/bookmarks".text = ''
            file:///home/leodev/DEV DEV
            file:///home/leodev/DOTFILES DOTFILES
            file:///home/leodev/Téléchargements Téléchargements
          '';
    };

    programs.git = {
        enable = true;
        userName = settings.name;
        userEmail = settings.email;
        extraConfig = {
            init.defaultBranch = "main";
        };
    };

    imports = [
      ./gnome.nix
      ../themes/stylix.nix
      ./pkgs/zed-editor/default.nix
      ./pkgs/ghostty/default.nix
      ./pkgs/nerdfetch/default.nix
      ./pkgs/starship/default.nix
      ./pkgs/conky/default.nix
      ./pkgs/cava.nix
    ];

    home.packages = with pkgs; [
        nerd-fonts.zed-mono
        nerd-fonts.noto
        nerd-fonts.hack
        nerd-fonts.jetbrains-mono
    ];

    xdg.enable = true;

    gtk = {
        enable = true;
        iconTheme = {
            name = settings.icons;
            package = settings.iconsPkg;
        };
        theme = {
            name = lib.mkForce "adw-gtk3";
            package = lib.mkForce pkgs.adw-gtk3;
        };
    };

    home.file = {
      ".icons/bibata".source = "${settings.iconsPkg}/share/icons/Bibata-Modern-Classic";
    };

    home.stateVersion = "24.11";
}
