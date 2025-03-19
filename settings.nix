{pkgs, ...}: rec {
  locale = "fr_FR.UTF-8"; # Select locale
  keyMap = "us";
  variant = "mac";

  hostname = "nixos";
  username = "lmlab";

  name = "PoudaLePanda"; # Name (git config)
  email = "leo.meyniel@proton.me"; # Email (git config)

  themeAdw = "kanagawa"; # catppuccin, dracula, everforest, gruvbox, kanagawa, nord

  font = "Noto Nerd Font";
  fontSize = 13;

  # Session variables.
  editor = "zed";
  browser = "zen";
  term = "ghostty";
  avatarImage = ./assets/avatar.png;
}
