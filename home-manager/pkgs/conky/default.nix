# ./home/pkgs/conky/default.nix
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    conky
  ];

  xdg.configFile."conky/conky.conf".source = ./conky.conf;

  # Autostart de Conky (optionnel)
  xdg.configFile."autostart/conky.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=Conky
    Exec=conky --daemonize --pause=2
    StartupNotify=false
    Terminal=false
  '';
}
