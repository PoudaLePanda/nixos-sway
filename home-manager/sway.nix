{
  lib,
  config,
  pkgs,
  settings,
  ...
}: let
  modifier = config.wayland.windowManager.sway.config.modifier;
  themeDetails = settings.themeDetails;
in {
  imports = [
    ./sway/waybar.nix
  ];
  home.packages = with pkgs; [
    wmenu
    swaybg
    shotman
    waybar
  ];

  wayland.windowManager.sway = {
    enable = true;
    
    wrapperFeatures = {
      gtk = true;
      base = true;
    };

    xwayland = true;
    package = pkgs.sway;

    systemd = {
      enable = true;
      extraCommands = [
        "systemctl --user start sway-session.target"
      ];
      variables = [
        "DISPLAY"
        "WAYLAND_DISPLAY"
        "SWAYSOCK"
        "XDG_CURRENT_DESKTOP"
        "XDG_SESSION_TYPE"
        "NIXOS_OZONE_WL"
        "XCURSOR_THEME"
        "XCURSOR_SIZE"
        #"-all"
      ];
      xdgAutostart = false;
    };
  };

  # Activation pour copier la config par défaut de sway si elle n'existe pas déjà
  home.activation.setupSwayConfig = {
    after = [ "linkGeneration" ];
    data = ''
      if [ ! -f "$HOME/.config/sway/config" ]; then
        mkdir -p "$HOME/.config/sway"
        cp ${./sway/sway-config} "$HOME/.config/sway/config"
        chmod 644 "$HOME/.config/sway/config"
        chown $USER:$(id -gn $USER) "$HOME/.config/sway/config"
      fi
    '';
  };
}
