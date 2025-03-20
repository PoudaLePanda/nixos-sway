{config, ...}: {
  programs.waybar.settings = {
    mainBar = {
      layer = "top";
      position = "top";

      modules-left = [
        "custom/nixlogo"
        "custom/launcher"
        "sway/mode"
        "sway/workspaces"
        "hyprland/workspaces"
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
        "clock#date"
        "custom/arrow1"
        "clock#time"
        "custom/arrow2"
        "tray"
        "custom/power"
      ];

      "custom/nixlogo" = {
        format = "";
        tooltip = false;
        on-click = "swaync-client -t -sw";
      };

      "custom/power" = {
        format = "⏻ ";
        on-click = "swaynag -t warning -m 'Power options' -b 'Shutdown' 'shutdown now' -b 'Restart' 'reboot' -b 'Logout' 'swaymsg exit'";
      };

      "custom/notification" = {
        tooltip = false;
        format = "{icon} ";
        format-icons = {
          notification = "<span foreground='#${config.lib.stylix.colors.base08}'><sup></sup></span>  <span foreground='#${config.lib.stylix.colors.base08}'></span>";
          none = "  <span foreground='#${config.lib.stylix.colors.base08}'></span>";
          dnd-notification = "<span foreground='#${config.lib.stylix.colors.base08}'><sup></sup></span>  <span foreground='#${config.lib.stylix.colors.base08}'></span>";
          dnd-none = "  <span foreground='#${config.lib.stylix.colors.base08}'></span>";
          inhibited-notification = "<span foreground='#${config.lib.stylix.colors.base08}'><sup></sup></span>  <span foreground='#${config.lib.stylix.colors.base08}'></span>";
          inhibited-none = "  <span foreground='#${config.lib.stylix.colors.base08}'></span>";
          dnd-inhibited-notification = "<span foreground='#${config.lib.stylix.colors.base08}'><sup></sup></span>  <span foreground='#${config.lib.stylix.colors.base08}'></span>";
          dnd-inhibited-none = "  <span foreground='#${config.lib.stylix.colors.base08}'></span>";
        };
        return-type = "json";
        exec-if = "which swaync-client";
        exec = "swaync-client -swb";
        on-click = "swaync-client -t -sw";
        on-click-right = "swaync-client -d -sw";
        escape = true;
      };

      "hyprland/workspaces" = {
        active-only = false;
        disable-scroll = true;
        format = "{icon}";
        on-click = "activate";
        format-icons = {
          "1" = "1";
          "2" = "2";
          "3" = "3";
          "4" = "4";
          "5" = "5";
          "6" = "6";
          sort-by-number = true;
        };
        persistent-workspaces = {
          "1" = [];
          "2" = [];
          "3" = [];
          "4" = [];
          "5" = [];
          "6" = [];
        };
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
          sort-by-number = true;
        };
        persistent-workspaces = {
          "1" = [];
          "2" = [];
          "3" = [];
          "4" = [];
          "5" = [];
          "6" = [];
        };
      };

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
        format = "<span foreground='#${config.lib.stylix.colors.base00}'>󰟜 </span>{}%";
        format-alt = "<span foreground='#${config.lib.stylix.colors.base00}'>󰟜 </span>{used} GiB"; #
        interval = 2;
        on-click-right = "hyprctl dispatch exec '[float; center; size 950 650] kitty --override font_size=14 --title float_kitty btop'";
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
}
