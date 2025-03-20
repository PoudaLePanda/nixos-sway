# home-manager/pkgs/waybar/default.nix
{ config, lib, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        spacing = 10;
        
        modules-left = [
          "sway/workspaces"
          "sway/mode"
        ];
        
        modules-center = [
          "clock"
        ];
        
        modules-right = [
          "backlight"
          "pulseaudio"
          "network"
          "battery"
          "tray"
          "custom/power"
        ];
        
        "sway/workspaces" = {
          format = "{icon}";
          format-icons = {
            "1" = "󰈹";
            "2" = "";
            "3" = "";
            "4" = "";
            "5" = "";
          };
          on-click = "activate";
        };
        
        "sway/mode" = {
          format = "<span style=\"italic\">{}</span>";
        };
        
        "clock" = {
          format = "{:%H:%M}  ";
          format-alt = "{:%A, %d %B %Y}  ";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };
        
        "backlight" = {
          device = "intel_backlight";
          format = "{percent}% {icon}";
          format-icons = ["" "" "" "" "" "" "" "" ""];
        };
        
        "pulseaudio" = {
          format = "{volume}% {icon}";
          format-muted = "婢";
          format-icons = {
            default = ["" "" ""];
          };
          scroll-step = 5;
          on-click = "pavucontrol";
        };
        
        "network" = {
          format-wifi = "{essid} ({signalStrength}%) ";
          format-ethernet = "{ipaddr}/{cidr} ";
          format-linked = "{ifname} (No IP) ";
          format-disconnected = "Disconnected ⚠";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
          on-click = "networkmanager_dmenu";
        };
        
        "battery" = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-charging = "{capacity}% ";
          format-plugged = "{capacity}% ";
          format-alt = "{time} {icon}";
          format-icons = ["" "" "" "" ""];
        };
        
        "custom/power" = {
          format = "⏻";
          on-click = "swaynag -t warning -m 'Power options' -b 'Shutdown' 'shutdown now' -b 'Restart' 'reboot' -b 'Logout' 'swaymsg exit'";
        };
        
        "tray" = {
          spacing = 20;
        };
      };
    };
  };
  
  # Dépendances pour Waybar
  home.packages = with pkgs; [
    pavucontrol # Contrôle du volume audio
    networkmanager_dmenu # interface pour NetworkManager
    blueman # Gestionnaire Bluetooth graphique
    dunst # Gestionnaires de notifications
    swaylock # Verrouillage d'écran pour Sway
    swayidle # Gestion de l'inactivité
    swaybg # Gestionnaire de fond d'écran
    swaylock-effects # Version de swaylock avec effets visuels
    grim # Utilitaire de capture d'écran
    slurp # Sélection de zone pour capture d'écran
    brightnessctl # Contrôle de la luminosité
    playerctl # Contrôle des lecteurs multimédia
    rofi-wayland # Version Wayland de rofi
  ];
}