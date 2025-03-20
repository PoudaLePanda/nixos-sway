# host/hyprland.nix
{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.kitty.enable = true; # required for the default Hyprland config
  # Activer Hyprland au niveau du système
  programs.hyprland = {
    enable = true;
    # Optionnel : activer XWayland si nécessaire
    xwayland.enable = true;
  };

  # Remplacer ou ajouter le portail spécifique à Hyprland
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-hyprland];

  # Lancer Hyprland au démarrage via GDM en mode Wayland
  services.xserver.displayManager = {
    gdm.enable = true;
    gdm.wayland = true;
    # defaultSession = "hyprland";
  };
}
