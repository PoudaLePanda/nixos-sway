# host/sway.nix
{
  config,
  lib,
  pkgs,
  settings,
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
    swaylock-effects
    wayland
    xdg-utils
    glib # Pour gsettings et autres
    # Ajoutez ici d'autres paquets communs
  ];

  # Activer Sway au niveau du système
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true; # Pour une meilleure intégration avec GTK
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
        user = "greeter";
      };
      initial_session = {
        command = "sway";
        user = settings.username;
      };
    };
  };
  # Optionnel: s'assurer que pam permet à swaylock de fonctionner correctement
  security.pam.services.swaylock = {};

  # Permet de lancer Sway au démarrage
  services.xserver.displayManager = {
    gdm.enable = false;
    gdm.wayland = true;
    # Vous pouvez désactiver la ligne suivante si vous ne voulez pas de GDM
    defaultSession = "sway";
  };
}
