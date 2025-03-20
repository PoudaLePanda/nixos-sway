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

  # Permet de lancer Sway au démarrage
  services.xserver.displayManager = {
    gdm.enable = true;
    gdm.wayland = true;
    # Vous pouvez désactiver la ligne suivante si vous ne voulez pas de GDM
    # defaultSession = "sway";
  };
}
