{pkgs, ...}:
rec {
    locale = "fr_FR.UTF-8"; # Select locale
    keyMap = "us";
    variant = "mac";

    hostname = "nixos";
    username = "lmlab";

    name = "PoudaLePanda"; # Name (git config)
    email = "leo.meyniel@proton.me"; # Email (git config)

    dotfilesDir = "/home/${username}/DOTFILES"; # Absolute path of the local repo

    themeAdw = "everforest"; # everforest, catppuccin, nord, gruvbox
    themeDetails = import (./. + "/themes/${themeAdw}.nix") {dir = dotfilesDir;};

    font = "Noto Nerd Font";
    fontSize = 13;

    icons = "Nordzy";
    iconsPkg = pkgs.nordzy-icon-theme;

    # Session variables.
    editor = "zed";
    browser = "zen";
    term = "ghostty";
    avatarImage = ./assets/avatar.png;
}
