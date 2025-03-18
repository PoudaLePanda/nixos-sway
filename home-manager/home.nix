# ./home/home.nix
{
  config,
  inputs,
  lib,
  pkgs,
  settings,
  ...
}: {
  imports = [
    (import ../themes/gtk.nix {inherit pkgs lib settings;})
    ./gnome.nix
    ./pkgs/zed-editor/default.nix
    ./pkgs/ghostty/default.nix
    ./pkgs/nerdfetch/default.nix
    ./pkgs/starship/default.nix
    ./pkgs/conky/default.nix
    ./pkgs/cava.nix
    ../themes/stylix.nix
  ];

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

  home.packages = with pkgs; [
    nerd-fonts.zed-mono
    nerd-fonts.noto
    nerd-fonts.hack
    nerd-fonts.jetbrains-mono
  ];

  xdg.enable = true;

  home.stateVersion = "24.11";
}
