{lib, ...}: {
  wayland.windowManager.hyprland = {
    settings = lib.mkForce {
      # autostart
      exec-once = [
        # "hash dbus-update-activation-environment 2>/dev/null"
        "dbus-update-activation-environment --all --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"

        "nm-applet &"
        "poweralertd &"
        "wl-clip-persist --clipboard both &"
        "wl-paste --watch cliphist store &"
        "waybar &"
        "swaync &"
        "hyprctl setcursor Bibata-Modern-Ice 24 &"
        "swww-daemon &"
        "wofi &"

        "hyprlock"
      ];

      input = {
        kb_layout = "us,fr";
        kb_options = "grp:alt_caps_toggle";
        numlock_by_default = true;
        repeat_delay = 300;
        follow_mouse = 0;
        float_switch_override_focus = 0;
        mouse_refocus = 0;
        sensitivity = 0;
        touchpad = {
          natural_scroll = true;
        };
      };

      general = {
        "$modifier" = "Mod4"; # Touche Windows/Super (Command sur Mac)
        layout = "dwindle";
        gaps_in = 6;
        gaps_out = 12;
        border_size = 2;
        "col.active_border" = "rgb(98971A) rgb(CC241D) 45deg";
        "col.inactive_border" = "0x00000000";
        # border_part_of_window = false;
        no_border_on_floating = false;
      };

      misc = {
        disable_autoreload = true;
        disable_hyprland_logo = true;
        always_follow_on_dnd = true;
        layers_hog_keyboard_focus = true;
        animate_manual_resizes = false;
        enable_swallow = true;
        focus_on_activate = true;
        new_window_takes_over_fullscreen = 2;
        middle_click_paste = false;
      };

      dwindle = {
        force_split = 2;
        special_scale_factor = 1.0;
        split_width_multiplier = 1.0;
        use_active_for_splits = true;
        pseudotile = "yes";
        preserve_split = "yes";
      };

      master = {
        new_status = "master";
        special_scale_factor = 1;
      };

      decoration = {
        rounding = 0;
        # active_opacity = 0.90;
        # inactive_opacity = 0.90;
        # fullscreen_opacity = 1.0;

        blur = {
          enabled = true;
          size = 3;
          passes = 2;
          brightness = 1;
          contrast = 1.4;
          ignore_opacity = true;
          noise = 0;
          new_optimizations = true;
          xray = true;
        };

        shadow = {
          enabled = true;

          ignore_window = true;
          offset = "0 2";
          range = 20;
          render_power = 3;
          color = "rgba(00000055)";
        };
      };

      animations = {
        enabled = true;

        bezier = [
          "fluent_decel, 0, 0.2, 0.4, 1"
          "easeOutCirc, 0, 0.55, 0.45, 1"
          "easeOutCubic, 0.33, 1, 0.68, 1"
          "fade_curve, 0, 0.55, 0.45, 1"
        ];

        animation = [
          # name, enable, speed, curve, style

          # Windows
          "windowsIn,   0, 4, easeOutCubic,  popin 20%" # window open
          "windowsOut,  0, 4, fluent_decel,  popin 80%" # window close.
          "windowsMove, 1, 2, fluent_decel, slide" # everything in between, moving, dragging, resizing.

          # Fade
          "fadeIn,      1, 3,   fade_curve" # fade in (open) -> layers and windows
          "fadeOut,     1, 3,   fade_curve" # fade out (close) -> layers and windows
          "fadeSwitch,  0, 1,   easeOutCirc" # fade on changing activewindow and its opacity
          "fadeShadow,  1, 10,  easeOutCirc" # fade on changing activewindow for shadows
          "fadeDim,     1, 4,   fluent_decel" # the easing of the dimming of inactive windows
          # "border,      1, 2.7, easeOutCirc"  # for animating the border's color switch speed
          # "borderangle, 1, 30,  fluent_decel, once" # for animating the border's gradient angle - styles: once (default), loop
          "workspaces,  1, 4,   easeOutCubic, fade" # styles: slide, slidevert, fade, slidefade, slidefadevert
        ];
      };

      binds = {
        movefocus_cycles_fullscreen = true;
      };

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
        "$modifier, D, exec, wofi -show drun || pkill wofi"
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

      # windowrule
      windowrule = [
        "float,class:^(Viewnior)$"
        "float,class:^(imv)$"
        "float,class:^(mpv)$"
        "tile,class:^(Aseprite)$"
        "float,class:^(Audacious)$"
        "pin,class:^(rofi)$"
        "pin,class:^(waypaper)$"
        # "idleinhibit focus,mpv"
        # "float,udiskie"
        "float,title:^(Transmission)$"
        "float,title:^(Volume Control)$"
        "float,title:^(Firefox — Sharing Indicator)$"
        "move 0 0,title:^(Firefox — Sharing Indicator)$"
        "size 700 450,title:^(Volume Control)$"
        "move 40 55%,title:^(Volume Control)$"

        "float, title:^(Picture-in-Picture)$"
        "opacity 1.0 override 1.0 override, title:^(Picture-in-Picture)$"
        "pin, title:^(Picture-in-Picture)$"
        "opacity 1.0 override 1.0 override, title:^(.*imv.*)$"
        "opacity 1.0 override 1.0 override, title:^(.*mpv.*)$"
        "opacity 1.0 override 1.0 override, class:(Aseprite)"
        "opacity 1.0 override 1.0 override, class:(Unity)"
        "opacity 1.0 override 1.0 override, class:(zen)"
        "opacity 1.0 override 1.0 override, class:(evince)"
        "workspace 1, class:^(zen)$"
        "workspace 3, class:^(evince)$"
        "workspace 4, class:^(Gimp-2.10)$"
        "workspace 4, class:^(Aseprite)$"
        "workspace 5, class:^(Audacious)$"
        "workspace 5, class:^(Spotify)$"
        "workspace 8, class:^(com.obsproject.Studio)$"
        "workspace 10, class:^(discord)$"
        "workspace 10, class:^(WebCord)$"
        "idleinhibit focus, class:^(mpv)$"
        "idleinhibit fullscreen, class:^(firefox)$"
        "float,class:^(org.gnome.Calculator)$"
        "float,class:^(waypaper)$"
        "float,class:^(zenity)$"
        "size 850 500,class:^(zenity)$"
        "size 725 330,class:^(SoundWireServer)$"
        "float,class:^(org.gnome.FileRoller)$"
        "float,class:^(org.pulseaudio.pavucontrol)$"
        "float,class:^(SoundWireServer)$"
        "float,class:^(.sameboy-wrapped)$"
        "float,class:^(file_progress)$"
        "float,class:^(confirm)$"
        "float,class:^(dialog)$"
        "float,class:^(download)$"
        "float,class:^(notification)$"
        "float,class:^(error)$"
        "float,class:^(confirmreset)$"
        "float,title:^(Open File)$"
        "float,title:^(File Upload)$"
        "float,title:^(branchdialog)$"
        "float,title:^(Confirm to replace files)$"
        "float,title:^(File Operation Progress)$"

        "opacity 0.0 override,class:^(xwaylandvideobridge)$"
        "noanim,class:^(xwaylandvideobridge)$"
        "noinitialfocus,class:^(xwaylandvideobridge)$"
        "maxsize 1 1,class:^(xwaylandvideobridge)$"
        "noblur,class:^(xwaylandvideobridge)$"

        # No gaps when only
        "bordersize 0, floating:0, onworkspace:w[t1]"
        "rounding 0, floating:0, onworkspace:w[t1]"
        "bordersize 0, floating:0, onworkspace:w[tg1]"
        "rounding 0, floating:0, onworkspace:w[tg1]"
        "bordersize 0, floating:0, onworkspace:f[1]"
        "rounding 0, floating:0, onworkspace:f[1]"

        # "maxsize 1111 700, floating: 1"
        # "center, floating: 1"

        # Remove context menu transparency in chromium based apps
        "opaque,class:^()$,title:^()$"
        "noshadow,class:^()$,title:^()$"
        "noblur,class:^()$,title:^()$"
      ];

      #       # windowrulev2
      #       windowrulev2 = [
      #       ];

      # No gaps when only
      workspace = [
        "w[t1], gapsout:0, gapsin:0"
        "w[tg1], gapsout:0, gapsin:0"
        "f[1], gapsout:0, gapsin:0"
      ];
    };

    extraConfig = "
      monitor=,preferred,auto,auto

      xwayland {
        force_zero_scaling = true
      }
    ";
  };
}
