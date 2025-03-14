{ config, pkgs, ... }:
{
  services.xserver.desktopManager.gnome.enable = true;

  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    cheese
    epiphany
    geary
    seahorse
    totem
    gnome-maps
    gnome-music
    gnome-weather
    gnome-contacts
    gnome-calendar
    # Games
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
    iagno
    lightsoff
    quadrapassel
    swell-foop
    tali
  ];

  # Activer dconf pour gérer les réglages GNOME au niveau du système
  programs.dconf.enable = true;

  services.xserver.excludePackages = with pkgs; [xterm];
}
