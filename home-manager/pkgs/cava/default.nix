# Configuration Home-Manager pour Cava + MPV
{ config, pkgs, lib, ... }:

{
  # Installation des paquets nécessaires
  home.packages = with pkgs; [
    cava        # Visualiseur audio en console
    mpv         # Lecteur multimédia polyvalent
    ffmpeg      # Pour convertir la sortie de Cava en vidéo
    imagemagick # Pour la manipulation d'images
    xorg.xwininfo # Utilitaire pour gérer les fenêtres X11
    feh         # Alternative pour définir des images de fond
  ];

  # Configuration de Cava
  home.file.".config/cava/config".text = ''
    [general]
    framerate = 60
    bars = 100
    sensitivity = 100

    [input]
    method = pulse

    [output]
    method = raw
    raw_target = /tmp/cava.fifo
    data_format = ascii
    ascii_max_range = 1000

    [color]
    gradient = 1
    gradient_count = 8
    gradient_color_1 = '#59cc33'
    gradient_color_2 = '#80cc33'
    gradient_color_3 = '#a6cc33'
    gradient_color_4 = '#cccc33'
    gradient_color_5 = '#cca633'
    gradient_color_6 = '#cc8033'
    gradient_color_7 = '#cc5933'
    gradient_color_8 = '#cc3333'

    [smoothing]
    integral = 77
    monstercat = 1
    waves = 0
    gravity = 100
  '';

  # Configuration pour MPV
  home.file.".config/mpv/mpv.conf".text = ''
    # Configuration pour l'utilisation en arrière-plan
    background=yes
    screen=0
    geometry=100%:100%
    ontop=yes
    border=no
    alpha=blend
  '';

  # Script pour convertir la sortie de Cava en vidéo et l'afficher avec MPV
  home.file.".local/bin/cava-mpv.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      # Créer un FIFO si nécessaire
      if [ ! -e /tmp/cava.fifo ]; then
        mkfifo /tmp/cava.fifo
      fi

      # Nettoyer les fichiers temporaires précédents
      rm -f /tmp/cava_frame_*.png /tmp/cava.mp4

      # Lancer Cava en arrière-plan
      cava &
      CAVA_PID=$!

      # Nettoyer à la sortie
      trap "kill $CAVA_PID; rm -f /tmp/cava.fifo /tmp/cava_frame_*.png /tmp/cava.mp4; exit" INT TERM EXIT

      # Créer un fichier temporaire pour les images
      COUNTER=0
      WIDTH=1920
      HEIGHT=200

      # Créer une boucle pour générer des images à partir de la sortie de Cava
      while true; do
        # Lire une ligne de données depuis le FIFO de Cava
        if read -r line < /tmp/cava.fifo; then
          # Créer une image pour cette frame
          convert -size ''${WIDTH}x''${HEIGHT} xc:black /tmp/cava_tmp.png

          # Traiter chaque valeur dans la ligne
          i=0
          for val in $line; do
            # Calculer la hauteur de la barre basée sur la valeur
            bar_height=$((val * HEIGHT / 1000))

            # Déterminer la couleur basée sur la valeur
            # Gradient du vert au rouge
            r=$((val * 255 / 1000))
            g=$((255 - r))
            b=100

            # Dessiner la barre
            pos=$((i * WIDTH / 100))
            bar_width=$((WIDTH / 100))

            convert /tmp/cava_tmp.png -fill "rgb($r,$g,$b)" -draw "rectangle $pos,''${HEIGHT},$((pos+bar_width)),$((HEIGHT-bar_height))" /tmp/cava_tmp.png

            i=$((i+1))
          done

          # Enregistrer l'image générée
          cp /tmp/cava_tmp.png /tmp/cava_frame_$COUNTER.png
          COUNTER=$((COUNTER+1))

          # Toutes les 60 frames (environ 1 seconde), créer une vidéo et la lire avec MPV
          if [ $COUNTER -eq 60 ]; then
            ffmpeg -y -framerate 60 -pattern_type glob -i '/tmp/cava_frame_*.png' -c:v libx264 -pix_fmt yuv420p -shortest /tmp/cava.mp4 2>/dev/null

            # Si MPV n'est pas déjà en cours d'exécution, le lancer
            if ! pgrep -f "mpv --loop /tmp/cava.mp4" > /dev/null; then
              mpv --loop --wid=0 --no-audio /tmp/cava.mp4 --background=0.3 &
            else
              # Si MPV est déjà en cours d'exécution, il relira automatiquement le fichier mis à jour
              touch /tmp/cava.mp4
            fi

            # Réinitialiser le compteur et supprimer les anciennes images
            COUNTER=0
            rm -f /tmp/cava_frame_*.png
          fi
        else
          # Si le FIFO est fermé, sortir de la boucle
          break
        fi
      done

      # Attendre que Cava se termine
      wait $CAVA_PID
    '';
  };

  # Configuration pour le démarrage automatique
  xdg.configFile."autostart/cava-mpv.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=Cava MPV Visualizer
    Exec=${config.home.homeDirectory}/.local/bin/cava-mpv.sh
    Terminal=false
    Hidden=false
    X-GNOME-Autostart-enabled=true
  '';
}
