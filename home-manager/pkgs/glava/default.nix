# ./home/pkgs/cava/default.nix
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    glava
  ];

  # Configuration de Cava via un fichier externe
  xdg.configFile."glava".source = ./glava;

  # Autostart de Conky (optionnel)
  xdg.configFile."autostart/conky.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Exec=sh -c 'sleep 10 && glava --desktop'
    Hidden=false
    NoDisplay=false
    X-GNOME-Autostart-enabled=true
    Name[en_US]=Glava Audio Visualizer - Radial Mode
    Name=Glava Audio Visualizer - Radial Mode
    Comment[en_US]=Glava Audio Visualizer - Radial Mode
    Comment=Glava Audio Visualizer - Radial Mode
    X-GNOME-Autostart-Delay=10
  '';
}
