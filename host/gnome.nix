# ./host/gnome.nix
{ pkgs, ... }:
{
  services.xserver.desktopManager.gnome.enable = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
  };

  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-console
    epiphany
    geary
    seahorse
    cheese
    totem
    gnome-maps
    gnome-music
    gnome-weather
    gnome-terminal
    gnome-contacts
    gnome-calendar
    gnome-clocks
    aisleriot
    five-or-more
    four-in-a-row
    gnome-chess
    gnome-klotski
    gnome-mines
    gnome-nibbles
    gnome-robots
    gnome-sudoku
    gnome-tetravex
    hitori
    simple-scan
    iagno
    lightsoff
    quadrapassel
    swell-foop
    tali
  ];

  programs.dconf.enable = true;
  services.xserver.excludePackages = with pkgs; [xterm];
}
