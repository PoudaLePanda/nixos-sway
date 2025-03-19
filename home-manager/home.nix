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
    (import ../themes/gtk.nix {inherit pkgs lib settings;})
    ../themes/stylix.nix
    ./gnome.nix
    ./pkgs/zed-editor/default.nix
    ./pkgs/ghostty/default.nix
    ./pkgs/nerdfetch/default.nix
    ./pkgs/starship/default.nix
    ./pkgs/conky/default.nix
    ./pkgs/cava.nix
  ];

  stylix.targets.hyprland.enable = false;

  home = {
    username = settings.username;
    homeDirectory = "/home/${settings.username}";
    sessionVariables = {
      HOME_MANAGER_CONFIG = "$HOME/DOTFILES/home-manager/home.nix";
    };
  };

  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userName = settings.name;
    userEmail = settings.email;
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  home.packages = with pkgs; [
    nerd-fonts.zed-mono
    nerd-fonts.noto
    nerd-fonts.hack
    nerd-fonts.jetbrains-mono
  ];

  xdg.enable = true;

  home.stateVersion = "24.11";
}
