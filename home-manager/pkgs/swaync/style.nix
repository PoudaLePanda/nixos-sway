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
      background: #${config.lib.stylix.colors.base00};
      border: 1px solid #${config.lib.stylix.colors.base03};
    }
    tooltip label {
      margin: 5px;
      color: #${config.lib.stylix.colors.base05};
    }

    window#waybar {
    background-color: rgba(0, 0, 0, 0.5);
    color: #${config.lib.stylix.colors.base05};
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
      color: #${config.lib.stylix.colors.base05};
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
    color: #${config.lib.stylix.colors.base0A};
    }

    #mode,
    #custom-power,
    #custom-nixlogo {
    color: #${config.lib.stylix.colors.base05};
    background: #${config.lib.stylix.colors.base00};
    }

    #workspaces button {
    padding-left: 2pt;
    padding-right: 2pt;
    color: #${config.lib.stylix.colors.base05};
    background: #${config.lib.stylix.colors.base00};
    }

    #workspaces button.empty {
    color: #${config.lib.stylix.colors.base05};
    }
    #workspaces button.visible {
    color: #${config.lib.stylix.colors.base05};
    background: #${config.lib.stylix.colors.base00};
    }

    #workspaces button.focused {
    color: #${config.lib.stylix.colors.base05};
    background: #${config.lib.stylix.colors.base00};
    box-shadow: inset 0 -3px transparent;
    }

    #workspaces button.urgent {
    color: #${config.lib.stylix.colors.base05};
    background: #${config.lib.stylix.colors.base00};
    }

    #workspaces button:hover {
    background: #${config.lib.stylix.colors.base0C};
    color: #${config.lib.stylix.colors.base00};
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
    color: #${config.lib.stylix.colors.base00};
    background: transparent;
    }
  '';
}
