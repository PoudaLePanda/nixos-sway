# ./home/pkgs/conky/default.nix
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    conky
  ];

  xdg.configFile."conky/conky.conf".source = ./conky.conf;
  xdg.configFile."conky/mini_clock.lua".source = ./mini_clock.lua;
  xdg.configFile."conky/Circle.png".source = ./Circle.png;

  # Autostart de Conky (optionnel)
  # xdg.configFile."autostart/conky.desktop".text = ''
  #   [Desktop Entry]
  #   Type=Application
  #   Name=Conky
  #   Exec=conky --daemonize --pause=2
  #   # Exec=conky --daemonize --pause=2 -c ~/.config/conky/grumicela/Celaeno.conf & conky --daemonize --pause=2 -c ~/.config/conky/grumicela/Grumium2.conf
  #   # Exec=conky --daemonize --pause=2 -c ~/.config/conky/Celaeno.conf & conky --daemonize --pause=2 -c ~/.config/conky/conky2.conf
  #   StartupNotify=false
  #   Terminal=false
  # '';

  # Script de démarrage (optionnel)
  home.file.".local/bin/start-conky" = {
    source = ./start-conky;
    executable = true;
  };
}
