# home-manager/pkgs/waybar/default.nix
{ config, lib, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: "Noto Nerd Font";
        font-size: 13px;
        min-height: 0;
      }

      window#waybar {
        background: rgba(21, 18, 27, 0.8);
        color: #cdd6f4;
      }

      tooltip {
        background: #1e1e2e;
        border-radius: 10px;
        border-width: 2px;
        border-style: solid;
        border-color: #11111b;
      }

      #workspaces button {
        padding: 5px;
        color: #cdd6f4;
        margin-right: 5px;
      }

      #workspaces button.active {
        color: #a6adc8;
        background: #eba0ac;
        border-radius: 10px;
      }

      #workspaces button:hover {
        background: #11111b;
        color: #cdd6f4;
        border-radius: 10px;
      }

      #custom-language,
      #custom-updates,
      #custom-caffeine,
      #custom-power,
      #clock,
      #battery,
      #pulseaudio,
      #network,
      #workspaces,
      #tray,
      #backlight {
        background: #1e1e2e;
        padding: 0px 10px;
        margin: 3px 0px;
        border-radius: 10px;
      }

      #tray {
        border-radius: 10px;
        margin-right: 10px;
      }

      #workspaces {
        background: #1e1e2e;
        border-radius: 10px;
        margin-left: 10px;
        padding-right: 0px;
        padding-left: 5px;
      }

      #custom-caffeine {
        color: #89dceb;
        border-radius: 10px 0px 0px 10px;
        border-right: 0px;
        margin-left: 10px;
      }

      #custom-language {
        color: #f38ba8;
        border-left: 0px;
        border-right: 0px;
      }

      #custom-updates {
        color: #f5c2e7;
        border-radius: 10px 0px 0px 10px;
        border-left: 0px;
        border-right: 0px;
      }

      #clock {
        color: #fab387;
        border-radius: 10px;
        margin-left: 5px;
        margin-right: 5px;
      }

      #network {
        color: #f9e2af;
        border-radius: 10px 0px 0px 10px;
        border-left: 0px;
        border-right: 0px;
      }

      #pulseaudio {
        color: #89b4fa;
        border-radius: 0px 10px 10px 0px;
        border-left: 0px;
        border-right: 0px;
        margin-right: 5px;
      }

      #battery {
        color: #a6e3a1;
        border-radius: 0 10px 10px 0;
        margin-right: 10px;
        border-left: 0px;
      }

      #custom-power {
        color: #f38ba8;
        border-radius: 10px;
        margin-right: 10px;
        border-left: 0px;
      }

      #backlight {
        color: #cba6f7;
        border-radius: 10px 0px 0px 10px;
        border-left: 0px;
        border-right: 0px;
      }
    '';
    
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        spacing = 5;
        
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
          spacing = 10;
        };
      };
    };
  };
  
  # Dépendances pour Waybar
  home.packages = with pkgs; [
    pavucontrol
    networkmanager_dmenu
  ];
}