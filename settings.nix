{pkgs, ...}: rec {
  locale = "fr_FR.UTF-8"; # Select locale
  keyMap = "us";
  variant = "mac";

  hostname = "nixos";
  username = "lmlab";
  themeAdw = "everforest"; # catppuccin, dracula, everforest, gruvbox, kanagawa, nord

  dotfilesDir = "/home/${username}/.dotfiles"; # Absolute path of the local repo
  themeDetails = import (./. + "/themes/${themeAdw}.nix") {dir = dotfilesDir;};

  name = "PoudaLePanda"; # Name (git config)
  email = "leo.meyniel@proton.me"; # Email (git config)

  font = "Noto Nerd Font";
  fontSize = 13;

  # Session variables.
  editor = "zed";
  browser = "zen";
  term = "ghostty";
  avatarImage = ./assets/avatar.png;
}
