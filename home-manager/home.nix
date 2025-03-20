# ./home/home.nix
{
  inputs,
  pkgs,
  lib,
  settings,
  config,
  ...
}: {
  imports = [
    ./pkgs/bashrc.nix
    ./pkgs/btop/default.nix
    ./pkgs/fastfetch/default.nix
    ./pkgs/ghostty/default.nix
    ./pkgs/lazy-docker/default.nix
    ./pkgs/posting/default.nix
    ./pkgs/starship/default.nix
    ./pkgs/yazi/default.nix
    ./pkgs/zed-editor/default.nix
    ./pkgs/cava/default.nix
    ./pkgs/minecraft.nix
    ./pkgs/git.nix
    ./pkgs/bat.nix
    # sway
    ./pkgs/sway/default.nix
    # wayland
    ./pkgs/swaync/swaync.nix
    ./pkgs/waybar/default.nix
    # ./pkgs/wofi/default.nix
    ./pkgs/rofi/default.nix
  ];

  home.packages = with pkgs; [
    eyedropper
    foot
    nerd-fonts.zed-mono
    nerd-fonts.noto
    nerd-fonts.hack
    nerd-fonts.jetbrains-mono
  ];

  home = {
    username = settings.username;
    homeDirectory = "/home/${settings.username}";
    sessionVariables = {
      HOME_MANAGER_CONFIG = "$HOME/DOTFILES/home-manager/home.nix";
    };
    pointerCursor = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 24;
    };
  };

  gtk = {
    enable = true;
    font = {
      name = "Noto Nerd Font";
      size = 12;
    };
    theme = {
      name = "Colloid-Green-Dark-Gruvbox";
      package = pkgs.colloid-gtk-theme.override {
        colorVariants = ["dark"];
        themeVariants = ["green"];
        tweaks = [
          "gruvbox"
          "rimless"
          "float"
        ];
      };
    };
    iconTheme = {
      name = "Gruvbox-Plus-Dark";
      package = pkgs.gruvbox-plus-icons;
    };
    cursorTheme = {
      name = "Capitaine Cursors (Gruvbox)";
      package = pkgs.capitaine-cursors-themed;
      size = 24;
    };
  };

  programs.home-manager.enable = true;

  xdg.enable = true;

  home.stateVersion = "24.11";
}
