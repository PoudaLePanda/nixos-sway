# ./home/pkgs/conky/default.nix
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    conky
  ];

  xdg.configFile."conky/conky.conf".source = ./conky.conf;
  xdg.configFile."conky/conky2.conf".source = ./conky2.conf;
  xdg.configFile."conky/mini_clock.lua".source = ./mini_clock.lua;
  xdg.configFile."conky/Circle.png".source = ./Circle.png;

  # Autostart de Conky (optionnel)
  xdg.configFile."autostart/conky.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=Conky
    # Exec=conky --daemonize --pause=2
    Exec=sh -c "conky --daemonize --pause=2 --config=${"$HOME"}/.config/conky/conky.conf & conky --daemonize --pause=3 --config=${"$HOME"}/.config/conky/conky2.conf"
    StartupNotify=false
    Terminal=false
  '';
}
