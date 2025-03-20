# host/sway.nix
{
  config,
  lib,
  pkgs,
  ...
}: {
  # Activer Sway au niveau du système
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true; # Pour une meilleure intégration avec GTK
  };

  # Polkit est nécessaire pour certaines actions d'administration
  security.polkit.enable = true;

  # Activer les services XDG Desktop Portal pour l'intégration avec les applications
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };

  # Permet de lancer Sway au démarrage
  services.xserver.displayManager = {
    gdm.enable = true;
    gdm.wayland = true;
    # Vous pouvez désactiver la ligne suivante si vous ne voulez pas de GDM
    # defaultSession = "sway";
  };

  # Paquets systèmes nécessaires
  environment.systemPackages = with pkgs; [
    wayland
    xdg-utils
    glib # Pour les paramètres gsettings
    # Ajoutez d'autres paquets système nécessaires ici
  ];
}
