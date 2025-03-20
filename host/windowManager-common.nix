# host/windowManager-common.nix
{
  config,
  lib,
  pkgs,
  ...
}: {
  # Configuration commune pour l'administration
  security.polkit.enable = true;

  # Activer les services XDG Desktop Portal
  xdg.portal = {
    enable = true;
    # La liste de portails peut être complétée ou écrasée dans les fichiers spécifiques
    extraPortals = [];
  };

  # Paquets système communs
  environment.systemPackages = with pkgs; [
    wayland
    xdg-utils
    glib # Pour gsettings et autres
    # Ajoutez ici d'autres paquets communs
  ];
}
