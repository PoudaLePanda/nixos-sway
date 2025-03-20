# home-manager/pkgs/sway/default.nix
{
  config,
  lib,
  pkgs,
  ...
}: {
  # Programmes complémentaires pour Sway
  home.packages = with pkgs; [
    swayfx
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
    package = pkgs.swayfx;
    enable = true;
    config = {
      terminal = "${pkgs.ghostty}/bin/ghostty"; # Vous pouvez remplacer par votre terminal préféré
      menu = "${pkgs.wofi}/bin/wofi --show drun";
      modifier = "Mod4"; # Touche Windows/Super (Command sur Mac)

      floating = {
        criteria = [{app_id = "org.gnome.Nautilus";}];
        enable = true;
      };

      # swayfx config
      swayfx = {
        blur = {
          enabled = true;
          passes = 3;
          brightness = 0.8;
        };

        shadows = {
          enabled = true;
          radius = 12;
          opacity = 0.7;
        };

        rounded_corners = {
          enabled = true;
          radius = 10; # Définis les coins arrondis
        };
      };
      #blur disable
      #blur_xray disable
      #blur_passes 0
      #blur_radius 5
      #shadows enable
      #shadow_blur_radius 10
      #corner_radius 0
      #layer_effects "waybar" shadows enable; corner_radius 0; blur disable

      startup = [
        # Launch Firefox on start
        {command = "zen";}
      ];

      # Configuration de base des espaces de travail
      # workspaceOutputAssign = [
      #   {
      #     workspace = "1";
      #     output = "eDP-1";
      #   }
      #   {
      #     workspace = "2";
      #     output = "eDP-1";
      #   }
      #   {
      #     workspace = "3";
      #     output = "eDP-1";
      #   }
      #   {
      #     workspace = "4";
      #     output = "eDP-1";
      #   }
      #   {
      #     workspace = "5";
      #     output = "eDP-1";
      #   }
      #   {
      #     workspace = "6";
      #     output = "eDP-1";
      #   }
      # ];

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

      # modes = {
      #   resize = {
      #     "j" = "resize shrink width 10 px or 10 ppt";
      #     "k" = "resize grow height 10 px or 10 ppt";
      #     "l" = "resize shrink height 10 px or 10 ppt";
      #     "m" = "resize grow width 10 px or 10 ppt";

      #     "Left" = "resize shrink width 10 px or 10 ppt";
      #     "Down" = "resize grow height 10 px or 10 ppt";
      #     "Up" = "resize shrink height 10 px or 10 ppt";
      #     "Right" = "resize grow width 10 px or 10 ppt";

      #     "Return" = "mode default";
      #     "Escape" = "mode default";
      #     "${modifier}+r" = "mode default";
      #   };
      # };
      # Apparence
      gaps = {
        inner = 10;
        outer = -10;
        top = -5;
        bottom = 0;
      };

      # Configuration des fenêtres
      window = {
        border = 1;
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

    extraConfig = ''
      # Règles de mise en page personnalisées
      for_window [app_id="pavucontrol"] floating enable
      for_window [app_id="nm-connection-editor"] floating enable

      # Démarrer Waybar
      exec_always --no-startup-id ${pkgs.waybar}/bin/waybar

      # Créer le dossier Screenshots s'il n'existe pas
      exec mkdir -p ~/Screenshots

      # Fond d'écran (nécessite swaybg)
      # exec ${pkgs.swaybg}/bin/swaybg -i $C{pkgs.nixos-artwork.wallpapers.nineish-dark-gray.gnomeFilePath} -m fill
    '';
  };

  # Ajout de la configuration spécifique à swayfx
  xdg.configFile."sway/config".text = ''
    include /etc/sway/config

    # Effets SwayFX
    swayfx blur enable
    swayfx blur passes 3
    swayfx blur brightness 0.8

    swayfx shadows enable
    swayfx shadows radius 12
    swayfx shadows opacity 0.7

    swayfx rounded enable
    swayfx rounded radius 10
  '';
}
