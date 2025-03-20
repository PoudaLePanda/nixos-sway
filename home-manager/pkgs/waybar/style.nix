{config, ...}: {
  programs.waybar.style = ''
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
    -gtk-icon-shadow: none;
    }

    tooltip {
      background: #282828;
      border: 1px solid #504945;
    }
    tooltip label {
      margin: 5px;
      color: #ebdbb2;
    }

    window#waybar {
    background-color: rgba(0, 0, 0, 0.5);
    color: #ebdbb2;
    font-family: Noto Nerd Font;
    font-size: 10pt;
    transition-duration: 0.5s;
    }

    #custom-notification {
      margin-left: 15px;
      padding-right: 2px;
      margin-right: 5px;
    }

    #custom-launcher {
      font-size: 20px;
      color: #ebdbb2;
      font-weight: bold;
      margin-left: 15px;
      padding-right: 10px;
    }

    #custom-nixlogo,
    #custom-power,
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
    #mpris, #custom-notification {
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
    color: #d79921;
    }

    #mode,
    #custom-power,
    #custom-nixlogo {
    color: #ebdbb2;
    background: #282828;
    }

    #workspaces button {
    padding-left: 2pt;
    padding-right: 2pt;
    color: #ebdbb2;
    background: #282828;
    }

    #workspaces button.empty {
    color: #ebdbb2;
    }
    #workspaces button.visible {
    color: #ebdbb2;
    background: #282828;
    }

    #workspaces button.focused {
    color: #ebdbb2;
    background: #282828;
    box-shadow: inset 0 -3px transparent;
    }

    #workspaces button.urgent {
    color: #ebdbb2;
    background: #282828;
    }

    #workspaces button:hover {
    background: #689d6a;
    color: #282828;
    }

    #window {
    margin-right: 35pt;
    margin-left: 35pt;
    }

    #pulseaudio {
    background: #d3869b;
    color: #282828;
    }

    #network {
    background: #d3869b;
    color: #282828;
    }

    #memory {
    background: #689d6a;
    color: #282828;
    }

    #cpu {
    background: #98971a;
    color: #282828;
    }

    #temperature {
    background: #98971a;
    color: #282828;
    }

    #language {
    background: #d79921;
    color: #282828;
    }

    #battery {
    background: #689d6a;
    color: #ebdbb2;
    }

    #tray {
    background: #282828;
    }

    #clock.date {
    background: #d79921;
    color: #282828;
    }

    #clock.time {
    background: #ebdbb2;
    color: #282828;
    }

    #custom-arrow1 {
    font-size: 11pt;
    color: #ebdbb2;
    background: #d79921;
    }

    #custom-arrow2 {
    font-size: 11pt;
    color: #282828;
    background: #ebdbb2;
    }

    #custom-arrow3 {
    font-size: 11pt;
    color: #d79921;
    background: #689d6a;
    }

    #custom-arrow4 {
    font-size: 11pt;
    color: #689d6a;
    background: #98971a;
    }

    #custom-arrow5 {
    font-size: 11pt;
    color: #98971a;
    background: #98971a;
    }

    #custom-arrow6 {
    font-size: 11pt;
    color: #98971a;
    background: #689d6a;
    }

    #custom-arrow7 {
    font-size: 11pt;
    color: #689d6a;
    background: #d3869b;
    }

    #custom-arrow8 {
    font-size: 11pt;
    color: #d3869b;
    background: #d3869b;
    }

    #custom-arrow9 {
    font-size: 11pt;
    color: #d3869b;
    background: transparent;
    }

    #custom-arrow10 {
    font-size: 11pt;
    color: #282828;
    background: transparent;
    }
  '';
}
