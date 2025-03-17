{pkgs, ...}:
rec {
    locale = "fr_FR.UTF-8"; # Select locale
    keyMap = "us";
    variant = "mac";

    username = "lmlab";
    hostname = "nixos";

    name = "PoudaLePanda"; # Name (git config)
    email = "leo.meyniel@proton.me"; # Email (git config)

    dotfilesDir = "/home/${username}/DOTFILES"; # Absolute path of the local repo

    themeAdw = "nord"; # everforest, catppuccin, nord, gruvbox
    themeDetails = import (./. + "/themes/${themeAdw}.nix") {dir = dotfilesDir;};

    # theme = "Colloid-Teal-Dark-Nord";
    # themePkg = (pkgs.colloid-gtk-theme.override {
    #   colorVariants = [ "dark" ];
    #   themeVariants = [ "teal" ];
    #   tweaks = [
    #     "nord"
    #     "rimless"
    #     "float"
    #   ];
    # });

    font = "Noto Nerd Font";
    fontSize = 13;
    icons = "Nordzy";
    iconsPkg = pkgs.nordzy-icon-theme;

    cursor = "Bibata-Modern-Ice";
    cursorPkg = pkgs.bibata-cursors;

    # Session variables.
    editor = "zed";
    browser = "zen";
    term = "ghostty";
    avatarImage = ./assets/avatar.png;
}
