# ./home/pkgs/conky/default.nix
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    conky
  ];

  xdg.configFile."conky/conky.conf".source = ./conky.conf;
  xdg.configFile."conky/mini_clock.lua".source = ./mini_clock.lua;
  xdg.configFile."conky/Circle.png".source = ./Circle.png;

#   xdg.configFile."conky/config".text = ''
#     conky.config = {
#     --==============================================================================

#     --  Created : 2021/Nov/13
#     --  This theme is for conky version 1.10.8 or newer
#     --
#     --  CELAENO
#     --  ( A part of Taurus Conky themes pack )
#     --
#     --  author  : Closebox73
#     --  license : Distributed under the terms of GPLv3
#     --  notes   : Created on 1366x768 Monitor

#     --==============================================================================

#     -- Size and Position settings --
#       alignment = 'bottom_left',
#       gap_x = 30,
#       gap_y = -40,
#       maximum_width = 500,
#       minimum_height = 550,
#       minimum_width = 500,

#     -- Text settings --
#       use_xft = true,
#       override_utf8_locale = true,
#       font = 'Comfortaa:size=9',

#     -- Color Settings --
#       default_color = 'white',
#       default_outline_color = 'white',
#       default_shade_color = 'white',
#       color1 = '#E5832F',

#     -- Window Settings --
#       background = false,
#       border_width = 1,
#       draw_blended = false,
#       draw_borders = false,
#       draw_graph_borders = false,
#       draw_outline = false,
#       draw_shades = false,
#       own_window = true,
#       own_window_colour = '#000000',
#       own_window_class = 'Conky',
#       own_window_argb_visual = true,
#       own_window_type = 'desktop',
#       own_window_transparent = true,
#       own_window_hints = 'undecorated,below,sticky,skip_taskbar,skip_pager',
#       stippled_borders = 0,

#     -- Others --
#       cpu_avg_samples = 2,
#       net_avg_samples = 2,
#       double_buffer = true,
#       out_to_console = false,
#       out_to_stderr = false,
#       extra_newline = false,
#       update_interval = 1,
#       uppercase = false,
#       use_spacer = 'none',
#       show_graph_scale = false,
#       show_graph_range = false,
#     }

#     conky.text = [[
#     ${image ~/.config/conky/res/pink.png -p 60,160 -s 120x30}\
#     ${image ~/.config/conky/res/line.png -p 0,110 -s 45x5}\
#     ${image ~/.config/conky/res/ram.png -p 60,424 -s 50x50}\
#     ${image ~/.config/conky/res/cpu.png -p 150,424 -s 50x50}\
#     ${image ~/.config/conky/res/sys.png -p 240,424 -s 50x50}\
#     ${color grey}${Font Roboto:bold:size=10}${execi 1200 date -d -2day +%d}
#     ${voffset 35}${Font Roboto:bold:size=10}${color grey}${execi 1200 date -d -1day +%d}
#     ${offset 65}${voffset 8}${font Bebas Neue:Bold:size=50}${color}${time %d}${font}
#     ${alignc 129}${color}${voffset 22}${font Bebas Neue:size=16}${time %a  &  %b}
#     ${voffset -30}${color grey}${Font Roboto:bold:size=10}${execi 1200 date -d +1day +%d}
#     ${voffset 35}${color grey}${Font Roboto:bold:size=10}${execi 1200 date -d +2day +%d}
#     ${voffset 35}${color grey}${Font Roboto:bold:size=10}${execi 1200 date -d +3day +%d}
#     ${voffset 35}${color grey}${Font Roboto:bold:size=10}${execi 1200 date -d +4day +%d}${font}
#     ${offset 90}${voffset 65}${font Roboto:light:size=8}${memperc}${goto 185}${cpu cpu0}${goto 275}${fs_used_perc}
#     ]]
# '';
  # Autostart de Conky (optionnel)
  xdg.configFile."autostart/conky.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=Conky
    Exec=conky --daemonize --pause=2
    # Exec=conky --daemonize --pause=2 -c ~/.config/conky/grumicela/Celaeno.conf & conky --daemonize --pause=2 -c ~/.config/conky/grumicela/Grumium2.conf
    # Exec=conky --daemonize --pause=2 -c ~/.config/conky/Celaeno.conf & conky --daemonize --pause=2 -c ~/.config/conky/conky2.conf
    StartupNotify=false
    Terminal=false
  '';
}
