# ./home/pkgs/conky/default.nix
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    conky
  ];

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
