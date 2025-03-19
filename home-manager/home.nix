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
    # ./hyprland.nix
    ./pkgs/btop/default.nix
    ./pkgs/conky/default.nix
    ./pkgs/fastfetch/default.nix
    ./pkgs/ghostty/default.nix
    ./pkgs/lazy-docker/default.nix
    ./pkgs/nerdfetch/default.nix
    ./pkgs/posting/default.nix
    ./pkgs/starship/default.nix
    ./pkgs/yazi/default.nix
    ./pkgs/zed-editor/default.nix
    ./pkgs/cava.nix
    ./pkgs/spicetify.nix
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
    foot
    nerd-fonts.zed-mono
    nerd-fonts.noto
    nerd-fonts.hack
    nerd-fonts.jetbrains-mono
  ];

  xdg.enable = true;

  home.stateVersion = "24.11";
}
