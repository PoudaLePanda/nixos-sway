# ./host/pkgs/ghostty.nix
{ config, settings, ... }:
{
    xdg.configFile."ghostty/config".text = ''
        # Font
        font-family = ${settings.font}
        font-size = ${toString settings.fontSize}
        font-thicken = true
        font-feature = -liga,-dlig,-calt

        bold-is-bright = false
        adjust-box-thickness = 1

        # Theme
        theme = ${config.lib.stylix.ghosttyTheme}
        background-opacity = ${config.lib.stylix.opacity.terminal}
        background-blur = true
        unfocused-split-opacity = 0.96

        cursor-style = bar
        cursor-style-blink = false
        adjust-cursor-thickness = 1
        cursor-click-to-move = true

        # resize-overlay = never
        copy-on-select = true
        confirm-close-surface = false
        mouse-hide-while-typing = true

        window-theme = ghostty
        window-padding-x = 5
        window-padding-y = 5
        window-padding-balance = true
        window-padding-color = background
        window-inherit-working-directory = true
        window-inherit-font-size = true
        window-decoration = true

        # gtk-titlebar = true
        # gtk-single-instance = false
        # gtk-tabs-location = bottom
        # gtk-wide-tabs = false

        # auto-update = false
        term = xterm
        clipboard-paste-protection = false

        # keybind = shift+end=unbind
        # keybind = shift+home=unbind
        # keybind = ctrl+shift+left=unbind
        # keybind = ctrl+shift+right=unbind
        # keybind = shift+enter=text:\n
    '';
}
