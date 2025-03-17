# ./host/gnome.nix
{ pkgs, ... }:
{
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.excludePackages = with pkgs; [xterm];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
  };

  environment.gnome.excludePackages = with pkgs; [
    gnome-tour      # Welcome tour for new GNOME users
    gnome-console   # Terminal emulator for GNOME
    epiphany        # GNOME web browser
    geary           # Email client for GNOME
    seahorse        # GNOME password and key manager
    cheese          # Webcam application
    # totem           # Video player for GNOME
    gnome-maps      # Maps and navigation
    # gnome-music     # Music player
    gnome-weather   # Weather information app
    gnome-terminal  # Traditional terminal emulator
    gnome-contacts  # Contact manager
    gnome-calendar  # Calendar application
    gnome-clocks    # World clock and timer app
    aisleriot       # Solitaire card game collection
    five-or-more    # Line up colored balls game
    four-in-a-row   # Connect four style game
    gnome-chess     # Chess game
    gnome-klotski   # Sliding block puzzle game
    gnome-mines     # Minesweeper clone
    gnome-nibbles   # Snake game clone
    gnome-robots    # Avoid robot enemies game
    gnome-sudoku    # Number puzzle game
    gnome-tetravex  # Tile matching puzzle game
    hitori          # Logic puzzle game
    simple-scan     # Document scanning utility
    iagno           # Reversi board game
    lightsoff       # Light switching puzzle game
    quadrapassel    # Tetris clone
    swell-foop      # Same game - match and remove
    tali            # Poker dice game
  ];

  programs.dconf.enable = true;
}
