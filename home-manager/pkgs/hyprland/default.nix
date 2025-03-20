# home-manager/pkgs/hyprland/default.nix
{
  config,
  lib,
  pkgs,
  ...
}: {
  # Programmes complémentaires pour Hyprland
  home.packages = with pkgs; [
    hyprland # Le gestionnaire de fenêtres Hyprland
    hyprpaper # Pour le fond d'écran (si utilisé)
    waybar # Barre de statut (optionnel)
    wofi # Lanceur d'applications
    blueman # Gestionnaire Bluetooth graphique
    dunst # Gestionnaire de notifications
    playerctl # Contrôle multimédia
    # Vous pouvez ajouter d'autres paquets utiles
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland; # Utilisez la version de Hyprland souhaitée

    # La configuration Hyprland sera générée dans ~/.config/hypr/hyprland.conf
    config = {
      # Terminal par défaut (à remplacer par votre terminal préféré)
      terminal = "${pkgs.ghostty}/bin/ghostty";
      # Menu d'applications
      menu = "${pkgs.wofi}/bin/wofi --show drun";
      # Modificateur principal (ici "SUPER" pour la touche Windows/Super)
      modifier = "SUPER";

      # Commandes de démarrage (liste de commandes exécutées au lancement)
      startup = [
        "zen" # Exemple : lance la commande zen
      ];

      # Couleur de mise en surbrillance pour la fenêtre active (exemple)
      clientFocused = "#999999";

      # Raccourcis clavier : définis dans une chaîne multi-lignes en syntaxe Hyprland
      keybindings = ''
        bind = $mod, Return, exec, ${pkgs.foot}/bin/foot
        bind = $mod, d, exec, ${pkgs.wofi}/bin/wofi --show drun
        bind = $mod+Shift, q, killactive
        bind = $mod+Shift, c, reload
        bind = $mod+Shift, e, exec, swaynag -t warning -m "Voulez-vous quitter Hyprland?" -b "Oui" "hyprctl dispatch exit"

        # Navigation entre les espaces de travail
        bind = $mod, 1, workspace, 1
        bind = $mod, 2, workspace, 2
        bind = $mod, 3, workspace, 3
        bind = $mod, 4, workspace, 4
        bind = $mod, 5, workspace, 5
        bind = $mod, 6, workspace, 6

        # Déplacement des fenêtres entre espaces de travail
        bind = $mod+Shift, 1, move, workspace, 1
        bind = $mod+Shift, 2, move, workspace, 2
        bind = $mod+Shift, 3, move, workspace, 3
        bind = $mod+Shift, 4, move, workspace, 4
        bind = $mod+Shift, 5, move, workspace, 5
        bind = $mod+Shift, 6, move, workspace, 6

        # Focus et déplacement des fenêtres
        bind = $mod, h, focus, left
        bind = $mod, j, focus, down
        bind = $mod, k, focus, up
        bind = $mod, l, focus, right
        bind = $mod+Shift, h, move, left
        bind = $mod+Shift, j, move, down
        bind = $mod+Shift, k, move, up
        bind = $mod+Shift, l, move, right

        # Capture d'écran
        bind = $mod, Print, exec, grim -o $(hyprctl -j getoutputs | jq -r '.[] | select(.focused==true) | .name') ~/Screenshots/$(date +'%Y-%m-%d-%H%M%S').png
        bind = $mod+Shift, Print, exec, grim -g "$(slurp)" ~/Screenshots/$(date +'%Y-%m-%d-%H%M%S').png

        # Contrôle du volume
        bind = XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%
        bind = XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%
        bind = XF86AudioMute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle

        # Contrôle de la luminosité
        bind = XF86MonBrightnessDown, exec, brightnessctl set 5%-
        bind = XF86MonBrightnessUp, exec, brightnessctl set 5%+
      '';

      # Espacement entre fenêtres
      gaps = {
        inner = 10;
        outer = 10;
      };

      # Apparence des fenêtres
      window = {
        border = 2;
        titlebar = false;
      };

      # Configuration des périphériques d'entrée
      input = {
        "type:keyboard" = {
          xkb_layout = "us";
          xkb_variant = "mac"; # Disposition Mac US
          xkb_options = "ctrl:nocaps";
        };
        "type:touchpad" = {
          tap = "enabled";
          natural_scroll = "enabled";
        };
      };
    };
  };
}
