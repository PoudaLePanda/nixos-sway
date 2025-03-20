# host/hyprland.nix
{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  programs.kitty.enable = true; # required for the default Hyprland config
  # Activer Hyprland au niveau du système
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.default;
    portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
    # Optionnel : activer XWayland si nécessaire
    xwayland.enable = true;
  };

  # Remplacer ou ajouter le portail spécifique à Hyprland
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config = {
      common.default = ["gtk"];
      hyprland.default = [
        "gtk"
        "hyprland"
      ];
    };

    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };

  # Lancer Hyprland au démarrage via GDM en mode Wayland
  services.xserver.displayManager = {
    gdm.enable = true;
    gdm.wayland = true;
    # defaultSession = "hyprland";
  };
}
