# home-manager/pkgs/waybar/default.nix
{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";

        modules-left = [
          "sway/mode"
          "sway/workspaces"
          "custom/arrow10"
          "sway/window"
        ];

        modules-right = [
          "custom/arrow9"
          "pulseaudio"
          "custom/arrow8"
          "network"
          "custom/arrow7"
          "memory"
          "custom/arrow6"
          "cpu"
          "custom/arrow5"
          "temperature"
          "custom/arrow4"
          "custom/arrow3"
          "tray"
          "clock#date"
          "custom/arrow1"
          "clock#time"
          "custom/arrow2"
          "tray"
          "custom/power"
        ];

        "clock#time" = {
          interval = 10;
          format = "{:%H:%M}";
          tooltip = false;
        };

        "clock#date" = {
          interval = 20;
          format = "{:%e %b %Y}";
          tooltip = false;
          on-click = "gnome-calendar";
          # tooltip-format = "{:%e %B %Y}"
        };

        cpu = {
          interval = 5;
          tooltip = false;
          format = "  {max_frequency}GHz | {usage}%";
          format-alt = " {load}";
          states = {
            warning = 70;
            critical = 90;
          };
        };

        memory = {
          interval = 5;
          format = " {used:0.1f}G/{total:0.1f}G";
          states = {
            warning = 70;
            critical = 90;
          };
          tooltip = false;
        };

        network = {
          interval = 5;
          format-wifi = " {essid} ({signalStrength}%)";
          format-ethernet = "{ifname}: {ipaddr}/{cidr} ";
          format-disconnected = "";
          format-alt = " {ipaddr}/{cidr}";
          tooltip-format-wifi = "  {ifname} @ {essid}\nIP: {ipaddr}\nStrength: {signalStrength}%\nFreq: {frequency}MHz\n {bandwidthUpBits}  {bandwidthDownBits}";
          tooltip-format-ethernet = " {ifname}\nIP: {ipaddr}\n {bandwidthUpBits}  {bandwidthDownBits}";
        };

        "sway/mode" = {
          format = "{}";
          tooltip = false;
        };

        "sway/window" = {
          format = "{}";
          max-length = 50;
          tooltip = false;
        };

        "sway/workspaces" = {
          all-outputs = true;
          format = "{icon}";
          format-icons = {
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
            "6" = "6";
          };
        };

        pulseaudio = {
          format = "{icon} {volume}% {format_source}";
          format-bluetooth = "{icon} {volume}% {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = " {format_source}";
          format-source = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = ["" ""];
          };
          scroll-step = 1;
          # on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
          on-click = "pavucontrol";
          on-click-right = "pactl set-source-mute @DEFAULT_SOURCE@ toggle";
          tooltip = false;
        };

        temperature = {
          critical-threshold = 90;
          interval = 5;
          format = "{icon} {temperatureC}°";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
          tooltip = false;
        };

        "custom/power" = {
          format = "⏻ ";
          on-click = "swaynag -t warning -m 'Power options' -b 'Shutdown' 'shutdown now' -b 'Restart' 'reboot' -b 'Logout' 'swaymsg exit'";
        };

        tray = {
          icon-size = 18;
          # spacing = 10;
        };

        "custom/arrow1" = {
          format = "";
          tooltip = false;
        };

        "custom/arrow2" = {
          format = "";
          tooltip = false;
        };

        "custom/arrow3" = {
          format = "";
          tooltip = false;
        };

        "custom/arrow4" = {
          format = "";
          tooltip = false;
        };

        "custom/arrow5" = {
          format = "";
          tooltip = false;
        };

        "custom/arrow6" = {
          format = "";
          tooltip = false;
        };

        "custom/arrow7" = {
          format = "";
          tooltip = false;
        };

        "custom/arrow8" = {
          format = "";
          tooltip = false;
        };

        "custom/arrow9" = {
          format = "";
          tooltip = false;
        };

        "custom/arrow10" = {
          format = "";
          tooltip = false;
        };
      };
    };
    style = ''
      @keyframes blink-critical {
        to {
            background-color: rgba(0, 0, 0, 0);
        }
      }

      * {
        border: none;
        border-radius: 0;
        min-height: 0;
        margin: 0;
        padding: 0;
        box-shadow: none;
        text-shadow: none;
        icon-shadow: none;
      }

      window#waybar {
        background-color: rgba(00, 00, 00, 0.1);
        color: #${config.lib.stylix.colors.base05};
        font-family: Noto Nerd Font;
        font-size: 10pt;
        transition-duration: 0.5s;
      }

      #battery,
      #clock,
      #cpu,
      #language,
      #memory,
      #mode,
      #network,
      #pulseaudio,
      #temperature,
      #tray,
      #backlight,
      #idle_inhibitor,
      #disk,
      #user,
      #mpris {
        padding-left: 8pt;
        padding-right: 8pt;
      }

      #mode,
      #memory.critical,
      #cpu.critical,
      #temperature.critical,
      #battery.critical.discharging {
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
        animation-name: blink-critical;
        animation-duration: 1s;
      }

      #network.disconnected,
      #memory.warning,
      #cpu.warning,
      #temperature.warning,
      #battery.warning.discharging {
        color: #${config.lib.stylix.colors.base0A};
      }

      #mode {
        color: #${config.lib.stylix.colors.base05};
        background: #${config.lib.stylix.colors.base00};
      }

      #workspaces button {
        padding-left: 2pt;
        padding-right: 2pt;
        color: #${config.lib.stylix.colors.base00};
        background: #${config.lib.stylix.colors.base0C};
      }

      #workspaces button.visible {
          color: #${config.lib.stylix.colors.base00};
          background: #${config.lib.stylix.colors.base0C};
      }

      #workspaces button.focused {
        color: #${config.lib.stylix.colors.base00};
        background: #${config.lib.stylix.colors.base0C};
        box-shadow: inset 0 -3px transparent;
      }

      #workspaces button.urgent {
        color: #${config.lib.stylix.colors.base00};
        background: #${config.lib.stylix.colors.base0C};
      }

      #workspaces button:hover {
        background: #${config.lib.stylix.colors.base00};
        color: #${config.lib.stylix.colors.base0C};
      }

      #window {
        margin-right: 35pt;
        margin-left: 35pt;
      }

      #pulseaudio {
        background: #${config.lib.stylix.colors.base0E};
        color: #${config.lib.stylix.colors.base00};
      }

      #network {
        background: #${config.lib.stylix.colors.base0E};
        color: #${config.lib.stylix.colors.base00};
      }

      #memory {
        background: #${config.lib.stylix.colors.base0C};
        color: #${config.lib.stylix.colors.base00};
      }

      #cpu {
        background: #${config.lib.stylix.colors.base0B};
        color: #${config.lib.stylix.colors.base00};
      }

      #temperature {
        background: #${config.lib.stylix.colors.base0B};
        color: #${config.lib.stylix.colors.base00};
      }

      #language {
        background: #${config.lib.stylix.colors.base0A};
        color: #${config.lib.stylix.colors.base00};
      }

      #battery {
        background: #${config.lib.stylix.colors.base0C};
        color: #${config.lib.stylix.colors.base05};
      }

      #tray {
        background: #${config.lib.stylix.colors.base00};
      }

      #clock.date {
        background: #${config.lib.stylix.colors.base0A};
        color: #${config.lib.stylix.colors.base00};
      }

      #clock.time {
        background: #${config.lib.stylix.colors.base05};
        color: #${config.lib.stylix.colors.base00};
      }

      #custom-arrow1 {
        font-size: 11pt;
        color: #${config.lib.stylix.colors.base05};
        background: #${config.lib.stylix.colors.base0A};
      }

      #custom-arrow2 {
        font-size: 11pt;
        color: #${config.lib.stylix.colors.base00};
        background: #${config.lib.stylix.colors.base05};
      }

      #custom-arrow3 {
        font-size: 11pt;
        color: #${config.lib.stylix.colors.base0A};
        background: #${config.lib.stylix.colors.base0C};
      }

      #custom-arrow4 {
        font-size: 11pt;
        color: #${config.lib.stylix.colors.base0C};
        background: #${config.lib.stylix.colors.base0B};
      }

      #custom-arrow5 {
        font-size: 11pt;
        color: #${config.lib.stylix.colors.base0B};
        background: #${config.lib.stylix.colors.base0B};
      }

      #custom-arrow6 {
        font-size: 11pt;
        color: #${config.lib.stylix.colors.base0B};
        background: #${config.lib.stylix.colors.base0C};
      }

      #custom-arrow7 {
        font-size: 11pt;
        color: #${config.lib.stylix.colors.base0C};
        background: #${config.lib.stylix.colors.base0E};
      }

      #custom-arrow8 {
        font-size: 11pt;
        color: #${config.lib.stylix.colors.base0E};
        background: #${config.lib.stylix.colors.base0E};
      }

      #custom-arrow9 {
        font-size: 11pt;
        color: #${config.lib.stylix.colors.base0E};
        background: transparent;
      }

      #custom-arrow10 {
        font-size: 11pt;
        color: #${config.lib.stylix.colors.base0C};
        background: transparent;
      }
    '';
  };

  # Dépendances pour Waybar
  home.packages = with pkgs; [
    pavucontrol # Contrôle du volume audio
    networkmanager_dmenu # interface pour NetworkManager
  ];
}
