# ./home/pkgs/cava/default.nix
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    glava
  ];

  # Configuration de Cava via un fichier externe
  xdg.configFile."glava/bars.glsl".source = ./bars.glsl;
  xdg.configFile."glava/circle.glsl".source = ./circle.glsl;
  xdg.configFile."glava/env_awesome.glsl".source = ./env_awesome.glsl;
  xdg.configFile."glava/env_default.glsl".source = ./env_default.glsl;
  xdg.configFile."glava/env_i3.glsl".source = ./env_i3.glsl;
  xdg.configFile."glava/env_KWin.glsl".source = ./env_KWin.glsl;
  xdg.configFile."glava/env_Openbox.glsl".source = ./env_Openbox.glsl;
  xdg.configFile."glava/env_spectrwm.glsl".source = ./env_spectrwm.glsl;
  xdg.configFile."glava/env_Xfwm4.glsl".source = ./env_Xfwm4.glsl;
  xdg.configFile."glava/graph.glsl".source = ./graph.glsl;
  xdg.configFile."glava/radial.glsl".source = ./radial.glsl;
  xdg.configFile."glava/radial_aurora_01.glsl".source = ./radial_aurora_01.glsl;
  xdg.configFile."glava/radial_frost_01".source = ./radial_frost_01.glsl;
  xdg.configFile."glava/rc.glsl".source = ./rc.glsl;
  xdg.configFile."glava/rc.glsl.00".source = ./rc.glsl.00;
  xdg.configFile."glava/test_rc.glsl".source = ./test_rc.glsl;
  xdg.configFile."glava/wave.glsl".source = ./wave.glsl;

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
