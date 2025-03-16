# ./home/pkgs/conky/default.nix
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    conky
  ];

  # Configuration de Conky via un fichier externe
  xdg.configFile."conky/Porrima.conf".source = ./Porrima.conf;


  # Ajout des scripts utilisés par Conky
  xdg.configFile."conky/Porrima/scripts".source = ./scripts;
  xdg.configFile."conky/Porrima/res".source = ./res;
  xdg.configFile."conky/Porrima/fonts".source = ./fonts;

  # Autostart de Conky (optionnel)
  xdg.configFile."autostart/conky.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=Conky
    # Exec=conky --daemonize --pause=2
    Exec=conky --daemonize --pause=2 -c ~/.config/conky/Porrima.conf
    # Exec=conky --daemonize --pause=2 -c ~/.config/conky/Porrima.conf & conky --daemonize --pause=2 -c ~/.config/conky/conky2.conf
    StartupNotify=false
    Terminal=false
  '';
}
