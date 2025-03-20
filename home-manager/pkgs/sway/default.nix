# home-manager/pkgs/sway/default.nix
{
  config,
  lib,
  pkgs,
  ...
}: {
  # Programmes complémentaires pour Sway
  home.packages = with pkgs; [
    waybar # Barre de statut
    wofi # Lanceur d'applications
    blueman # Gestionnaire Bluetooth graphique
    dunst # Gestionnaires de notifications
    playerctl # Contrôle des lecteurs multimédia
    # rofi-wayland # Version Wayland de rofi
    # swaylock    # Verrouillage d'écran
    # swaylock-effects # Version de swaylock avec effets visuels
    # swayidle    # Gestion de l'écran de veille
    # foot        # Terminal léger pour Wayland
    # grim        # Capture d'écran
    # slurp       # Sélection de zone pour capture d'écran
    # wl-clipboard # Presse-papiers pour Wayland
    # mako        # Notifications
    # kanshi      # Gestion automatique des moniteurs
    # brightnessctl # Contrôle de la luminosité
    # swaybg      # Fond d'écran
    # jq          # Nécessaire pour le script de capture d'écran
  ];

  wayland.windowManager.sway = {
    enable = true;
    config = {
      terminal = "${pkgs.ghostty}/bin/ghostty";
      menu = "${pkgs.wofi}/bin/wofi --show drun";
      modifier = "Mod4"; # Touche Windows/Super (Command sur Mac)

      startup = [
        {command = "waybar";}
        {command = "zen";}
        {command = "swaync";}
      ];

      # client = {
      #   focused = "#999999 #5f676a #999999 #999999   #999999";
      # };

      # Configuration des barres de statut
      bars = []; # Nous utilisons Waybar au lieu de la barre par défaut

      # Raccourcis clavier pour Mac US
      keybindings = let
        modifier = config.wayland.windowManager.sway.config.modifier;
      in
        lib.mkOptionDefault {
          "${modifier}+Return" = "exec ${config.wayland.windowManager.sway.config.terminal}";
          "${modifier}+d" = "exec ${config.wayland.windowManager.sway.config.menu}";
          "${modifier}+Shift+q" = "kill";
          "${modifier}+Shift+c" = "reload";
          "${modifier}+Shift+e" = "exec swaynag -t warning -m 'Voulez-vous quitter Sway?' -b 'Oui' 'swaymsg exit'";

          # Navigation entre les espaces de travail
          "${modifier}+1" = "workspace number 1";
          "${modifier}+2" = "workspace number 2";
          "${modifier}+3" = "workspace number 3";
          "${modifier}+4" = "workspace number 4";
          "${modifier}+5" = "workspace number 5";
          "${modifier}+6" = "workspace number 6";

          # Déplacer les fenêtres entre les espaces de travail
          "${modifier}+Shift+1" = "move container to workspace number 1";
          "${modifier}+Shift+2" = "move container to workspace number 2";
          "${modifier}+Shift+3" = "move container to workspace number 3";
          "${modifier}+Shift+4" = "move container to workspace number 4";
          "${modifier}+Shift+5" = "move container to workspace number 5";
          "${modifier}+Shift+6" = "move container to workspace number 6";

          # Gestion des fenêtres
          "${modifier}+h" = "focus left";
          "${modifier}+j" = "focus down";
          "${modifier}+k" = "focus up";
          "${modifier}+l" = "focus right";

          "${modifier}+Shift+h" = "move left";
          "${modifier}+Shift+j" = "move down";
          "${modifier}+Shift+k" = "move up";
          "${modifier}+Shift+l" = "move right";

          # Capture d'écran
          "${modifier}+Print" = "exec grim -o $(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name') ~/Screenshots/$(date +'%Y-%m-%d-%H%M%S').png";
          "${modifier}+Shift+Print" = "exec grim -g \"$(slurp)\" ~/Screenshots/$(date +'%Y-%m-%d-%H%M%S').png";

          # Contrôle du volume - adaptez selon votre clavier Mac
          "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
          "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
          "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";

          # Contrôle de la luminosité - adaptez selon votre clavier Mac
          "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
          "XF86MonBrightnessUp" = "exec brightnessctl set 5%+";
        };

      # Apparence
      gaps = {
        inner = 10;
        outer = 10;
      };

      # Configuration des fenêtres
      window = {
        border = 2;
        titlebar = false;
      };

      # Disposition clavier US Mac
      input = {
        "type:keyboard" = {
          xkb_layout = "us";
          xkb_variant = "mac"; # Disposition Mac US
          xkb_options = "ctrl:nocaps"; # Optionnel: transformer Caps Lock en Ctrl
        };
        "type:touchpad" = {
          tap = "enabled";
          natural_scroll = "enabled";
        };
      };
    };
  };
}
