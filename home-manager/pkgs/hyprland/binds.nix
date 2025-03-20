{lib, ...}: let
  toggle = program: let
    prog = builtins.substring 0 14 program;
  in "pkill ${prog} || uwsm app -- ${program}";
in {
  wayland.windowManager.hyprland = {
    settings = lib.mkForce {
      binds = {
        movefocus_cycles_fullscreen = true;
      };

      bindr = [
        # launcher
        "$modifier, D, exec, ${toggle "anyrun"}"
      ];
      bind = [
        # show keybinds list
        "$modifier, F1, exec, show-keybinds"

        # keybindings
        "$modifier, Return, exec, ghostty"
        "ALT, Return, exec, [float; size 1111 700] ghostty"
        "$modifier SHIFT, Return, exec, [fullscreen] ghostty"
        "$modifier, B, exec, hyprctl dispatch exec '[workspace 1 silent] zen'"
        "$modifier, Q, killactive,"
        "$modifier, F, fullscreen, 0"
        "$modifier SHIFT, F, fullscreen, 1"
        "$modifier, Space, exec, toggle_float"
        # "$modifier, D, exec, ${toggle "anyrun"}"
        "$modifier SHIFT, D, exec, webcord --enable-features=UseOzonePlatform --ozone-platform=wayland"
        "$modifier SHIFT, S, exec, hyprctl dispatch exec '[workspace 5 silent] SoundWireServer'"
        "$modifier, Escape, exec, swaylock"
        # "ALT, Escape, exec, hyprlock"
        "$modifier SHIFT, Escape, exec, power-menu"
        "$modifier, P, pseudo,"
        "$modifier, X, togglesplit,"
        "$modifier, T, exec, toggle_oppacity"
        "$modifier, E, exec, nemo"
        "ALT, E, exec, hyprctl dispatch exec '[float; size 1111 700] nemo'"
        "$modifier SHIFT, E, exec, hyprctl dispatch exec '[float; size 1111 700] ghostty -e yazi'"
        "$modifier SHIFT, B, exec, toggle_waybar"
        "$modifier, C ,exec, hyprpicker -a"
        "$modifier, W,exec, wallpaper-picker"
        "$modifier SHIFT, W,exec, hyprctl dispatch exec '[float; size 925 615] waypaper'"
        "$modifier, N, exec, swaync-client -t -sw"
        "CTRL SHIFT, Escape, exec, hyprctl dispatch exec '[workspace 9] missioncenter'"
        "$modifier, equal, exec, woomer"
        # "$modifier SHIFT, W, exec, vm-start"

        # screenshot
        ",Print, exec, screenshot --copy"
        "$modifier, Print, exec, screenshot --save"
        "$modifier SHIFT, Print, exec, screenshot --swappy"

        # switch focus
        "$modifier, left,  movefocus, l"
        "$modifier, right, movefocus, r"
        "$modifier, up,    movefocus, u"
        "$modifier, down,  movefocus, d"
        "$modifier, h, movefocus, l"
        "$modifier, j, movefocus, d"
        "$modifier, k, movefocus, u"
        "$modifier, l, movefocus, r"

        "$modifier, left,  alterzorder, top"
        "$modifier, right, alterzorder, top"
        "$modifier, up,    alterzorder, top"
        "$modifier, down,  alterzorder, top"
        "$modifier, h, alterzorder, top"
        "$modifier, j, alterzorder, top"
        "$modifier, k, alterzorder, top"
        "$modifier, l, alterzorder, top"

        "CTRL ALT, up, exec, hyprctl dispatch focuswindow floating"
        "CTRL ALT, down, exec, hyprctl dispatch focuswindow tiled"

        # switch workspace
        "$modifier, 1, workspace, 1"
        "$modifier, 2, workspace, 2"
        "$modifier, 3, workspace, 3"
        "$modifier, 4, workspace, 4"
        "$modifier, 5, workspace, 5"
        "$modifier, 6, workspace, 6"
        "$modifier, 7, workspace, 7"
        "$modifier, 8, workspace, 8"
        "$modifier, 9, workspace, 9"
        "$modifier, 0, workspace, 10"

        # same as above, but switch to the workspace
        "$modifier SHIFT, 1, movetoworkspacesilent, 1" # movetoworkspacesilent
        "$modifier SHIFT, 2, movetoworkspacesilent, 2"
        "$modifier SHIFT, 3, movetoworkspacesilent, 3"
        "$modifier SHIFT, 4, movetoworkspacesilent, 4"
        "$modifier SHIFT, 5, movetoworkspacesilent, 5"
        "$modifier SHIFT, 6, movetoworkspacesilent, 6"
        "$modifier SHIFT, 7, movetoworkspacesilent, 7"
        "$modifier SHIFT, 8, movetoworkspacesilent, 8"
        "$modifier SHIFT, 9, movetoworkspacesilent, 9"
        "$modifier SHIFT, 0, movetoworkspacesilent, 10"
        "$modifier CTRL, c, movetoworkspace, empty"

        # window control
        "$modifier SHIFT, left, movewindow, l"
        "$modifier SHIFT, right, movewindow, r"
        "$modifier SHIFT, up, movewindow, u"
        "$modifier SHIFT, down, movewindow, d"
        "$modifier SHIFT, h, movewindow, l"
        "$modifier SHIFT, j, movewindow, d"
        "$modifier SHIFT, k, movewindow, u"
        "$modifier SHIFT, l, movewindow, r"

        "$modifier CTRL, left, resizeactive, -80 0"
        "$modifier CTRL, right, resizeactive, 80 0"
        "$modifier CTRL, up, resizeactive, 0 -80"
        "$modifier CTRL, down, resizeactive, 0 80"
        "$modifier CTRL, h, resizeactive, -80 0"
        "$modifier CTRL, j, resizeactive, 0 80"
        "$modifier CTRL, k, resizeactive, 0 -80"
        "$modifier CTRL, l, resizeactive, 80 0"

        "$modifier ALT, left, moveactive,  -80 0"
        "$modifier ALT, right, moveactive, 80 0"
        "$modifier ALT, up, moveactive, 0 -80"
        "$modifier ALT, down, moveactive, 0 80"
        "$modifier ALT, h, moveactive,  -80 0"
        "$modifier ALT, j, moveactive, 0 80"
        "$modifier ALT, k, moveactive, 0 -80"
        "$modifier ALT, l, moveactive, 80 0"

        # media and volume controls
        # ",XF86AudioMute,exec, pamixer -t"
        ",XF86AudioPlay,exec, playerctl play-pause"
        ",XF86AudioNext,exec, playerctl next"
        ",XF86AudioPrev,exec, playerctl previous"
        ",XF86AudioStop,exec, playerctl stop"

        "$modifier, mouse_down, workspace, e-1"
        "$modifier, mouse_up, workspace, e+1"

        # clipboard manager
        "$modifier, V, exec, cliphist list | rofi -dmenu -theme-str 'window {width: 50%;} listview {columns: 1;}' | cliphist decode | wl-copy"
      ];

      # # binds active in lockscreen
      # bindl = [
      #   # laptop brigthness
      #   ",XF86MonBrightnessUp, exec, brightnessctl set 5%+"
      #   ",XF86MonBrightnessDown, exec, brightnessctl set 5%-"
      #   "$modifier, XF86MonBrightnessUp, exec, brightnessctl set 100%+"
      #   "$modifier, XF86MonBrightnessDown, exec, brightnessctl set 100%-"
      # ];

      # # binds that repeat when held
      # binde = [
      #   ",XF86AudioRaiseVolume,exec, pamixer -i 2"
      #   ",XF86AudioLowerVolume,exec, pamixer -d 2"
      # ];

      # mouse binding
      bindm = [
        "$modifier, mouse:272, movewindow"
        "$modifier, mouse:273, resizewindow"
      ];
    };
  };
}
