# Configuration Home-Manager pour Impulse
{ config, pkgs, lib, ... }:

{
  # Installation du paquet Impulse et dépendances
  home.packages = with pkgs; [
    (pkgs.callPackage (
      { lib, stdenv, fetchFromGitHub, pkgconfig, fftw, ncurses, pulseaudio }:

      stdenv.mkDerivation rec {
        pname = "impulse";
        version = "unstable-2023-03-27";

        src = fetchFromGitHub {
          owner = "ianhalpern";
          repo = "Impulse";
          rev = "d957be6b37b222aaa9b40fd726a43a383c2aec57"; # Dernière version disponible
          sha256 = "sha256-t1xNbpVrPEDOQT15HRFnGUnyYwsj8GJmxKDzYIcYehs="; # Remplacer avec le hash correct
        };

        nativeBuildInputs = [ pkgconfig ];
        buildInputs = [ fftw ncurses pulseaudio ];

        buildPhase = ''
          make
        '';

        installPhase = ''
          mkdir -p $out/bin
          cp impulse $out/bin/
        '';

        meta = with lib; {
          description = "Impulse is a lightweight client for the PulseAudio sound server";
          homepage = "https://github.com/ianhalpern/Impulse";
          license = licenses.mit;
          platforms = platforms.linux;
        };
      }
    ) {})
    feh        # Pour définir le fond d'écran
    bc         # Calculatrice en ligne de commande utilisée dans le script
    imagemagick # Pour la création d'images
  ];

  # Script pour utiliser Impulse comme fond d'écran
  home.file.".local/bin/impulse-background.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      # Répertoire pour stocker les images temporaires
      TMPDIR="/tmp/impulse_wallpaper"
      mkdir -p $TMPDIR

      # Dimensions du fond d'écran
      WIDTH=1920
      HEIGHT=1080

      # Couleurs (format RGB)
      BG_COLOR="black"
      BAR_COLOR="blue"

      # Paramètres d'Impulse
      SAMPLES=64

      # Nettoyer à la sortie
      cleanup() {
        kill $IMPULSE_PID 2>/dev/null
        rm -rf $TMPDIR
        exit 0
      }

      trap cleanup INT TERM EXIT

      # Lancer Impulse en arrière-plan et capturer la sortie
      impulse -c $SAMPLES -s | while read -r line; do
        # Créer une image vide
        convert -size ''${WIDTH}x''${HEIGHT} xc:$BG_COLOR $TMPDIR/background.png

        # Transformer la sortie d'Impulse en barres
        values=($line)
        num_values=''${#values[@]}

        # Largeur de chaque barre
        bar_width=$((WIDTH / num_values))

        # Dessiner chaque barre
        for (( i=0; i<num_values; i++ )); do
          val=''${values[$i]}
          # Calculer la hauteur de la barre (échelle de 0-1.0 à 0-HEIGHT)
          height=$(echo "$val * $HEIGHT / 1.0" | bc -l | awk '{printf "%d", $0}')

          # Calculer la position x
          x_pos=$((i * bar_width))

          # Dessiner la barre
          convert $TMPDIR/background.png -fill "$BAR_COLOR" -draw "rectangle $x_pos,$HEIGHT $((x_pos+bar_width)),$((HEIGHT-height))" $TMPDIR/background.png
        done

        # Définir l'image comme fond d'écran
        feh --bg-scale $TMPDIR/background.png
      done &

      IMPULSE_PID=$!

      # Attendre que le script se termine
      wait $IMPULSE_PID
    '';
  };

  # Configuration pour le démarrage automatique
  xdg.configFile."autostart/impulse-background.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=Impulse Audio Visualizer
    Exec=${config.home.homeDirectory}/.local/bin/impulse-background.sh
    Terminal=false
    Hidden=false
    X-GNOME-Autostart-enabled=true
  '';
}
