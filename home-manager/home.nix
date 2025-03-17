# ./home/home.nix
{ config, inputs, pkgs, settings, ... }:
# let
#   gtk4ThemeDir = "${settings.themePkg}/share/themes/${settings.theme}";
# in
{
    home.sessionVariables = {
        HOME_MANAGER_CONFIG = "$HOME/DOTFILES/nixos-config/home-manager/home.nix";
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
      ./pkgs/nerdfetch/default.nix
      ./pkgs/starship/default.nix
      ./pkgs/conky/default.nix
      ./pkgs/zed-editor.nix
      ./pkgs/ghostty.nix
      ./pkgs/btop/default.nix
    ];

    home.packages = with pkgs; [
        blanket
        nerd-fonts.zed-mono
        nerd-fonts.noto
        nerd-fonts.hack
        nerd-fonts.jetbrains-mono
    ];

    xdg.enable = true;
    # xdg.userDirs = {
    #     enable = true;
    #     createDirectories = true;
    #     musique = "${config.home.homeDirectory}/Media/Musique";
    #     videos = "${config.home.homeDirectory}/Media/Vidéos";
    #     images = "${config.home.homeDirectory}/Media/Images";
    #     download = "${config.home.homeDirectory}/Téléchargement";
    #     documents = "${config.home.homeDirectory}/Documents";
    #     templates = null;
    #     desktop = null;
    #     publicShare = null;
    #     extraConfig = {
    #         XDG_DOTFILES_DIR = "${settings.dotfilesDir}";
    #         XDG_DEV_DIR = "${config.home.homeDirectory}/DEV";
    #     };
    # };

    # gtk = {
    #     enable = true;
    #     font = {
    #         name = settings.font;
    #         size = settings.fontSize;
    #     };
    #     iconTheme = {
    #       name = settings.icons;
    #     };
    #     cursorTheme = {
    #         name = settings.cursor;
    #         size = 24;
    #     };
    #     theme = {
    #         name = settings.theme;
    #     };
    #     gtk3.extraConfig = {
    #       gtk-application-prefer-dark-theme = true;
    #     };
    #     gtk4.extraConfig = {
    #       gtk-application-prefer-dark-theme = true;
    #     };
    # };

    # home.pointerCursor = {
    #     size = 24;
    #     name = settings.cursor;
    #     package = settings.cursorPkg;
    # };

    # home.file.".config/gtk-4.0/assets".source = "${gtk4ThemeDir}/gtk-4.0/assets";
    # home.file.".config/gtk-4.0/gtk.css".source = "${gtk4ThemeDir}/gtk-4.0/gtk.css";
    # home.file.".config/gtk-4.0/gtk-dark.css".source = "${gtk4ThemeDir}/gtk-4.0/gtk-dark.css";
    # home.file.".config/gtk-4.0/thumbnail.png".source = "${gtk4ThemeDir}/gtk-4.0/thumbnail.png";

    home.stateVersion = "24.11";
}
