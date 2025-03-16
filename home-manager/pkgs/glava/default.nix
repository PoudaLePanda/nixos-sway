# Configuration Home-Manager pour GLava
{ pkgs, lib, ... }:

{
  # Installation de GLava
  home.packages = with pkgs; [
    glava
  ];

  # Script d'initialisation qui sera exécuté lors de l'activation de home-manager
  home.activation.initGlava = lib.hm.dag.entryAfter ["writeBoundary"] ''
      # Créer le répertoire GLava s'il n'existe pas
      mkdir -p ~/.config/glava

      # Exécuter glava avec l'option copy-config pour générer les fichiers par défaut
      # Le || true permet d'ignorer le code de sortie en cas d'erreur
      ${pkgs.glava}/bin/glava --copy-config || true

      # Si les fichiers ont été générés dans ~/.config/glava/glava, les déplacer dans ~/.config/glava
      if [ -d ~/.config/glava/glava ]; then
        # Copier les fichiers, en remplaçant uniquement ceux qui n'ont pas été personnalisés
        cp -rn ~/.config/glava/glava/* ~/.config/glava/

        # Nettoyer le dossier supplémentaire
        rm -rf ~/.config/glava/glava
      fi

      echo "Configuration GLava initialisée avec succès"
    '';

  # Configuration principale de GLava
  home.file.".config/glava/rc.glsl".text = ''
    /* The module to use. A module is a set of shaders used to produce
       the visualizer. The structure for a module is the following:

       module_name [directory]
           1.frag [file: fragment shader],
           2.frag [file: fragment shader],
           ...

       Shaders are loaded in numerical order, starting at '1.frag',
       continuing indefinitely. The results of each shader (except
       for the final pass) is given to the next shader in the list
       as a 2D sampler.

       See documentation for more details. */
    #request mod radial

    /* Window hints */
    #request setfloating  false
    #request setdecorated true
    #request setfocused   false
    #request setmaximized false

    /* Set window background opacity mode. Possible values are:

       "native" - True transparency provided by the compositor. Can
                  reduce performance on some systems, depending on
                  the compositor used.

       "xroot"  - Maintain a copy of the root window's pixmap
                  (usually the desktop background) to provide a
                  pseudo-transparent effect. Useful when no compositor
                  is available or native transparency isn't nessecary.
                  Has very little performance impact.

       "none"   - Disable window opacity completely. */
    #request setopacity "native"

    /* Whether to mirror left and right audio input channels from PulseAudio.*/
    #request setmirror false

    /* OpenGL context and GLSL shader versions, do not change unless
       you *absolutely* know what you are doing. */
    #request setversion 3 3
    #request setshaderversion 330

    /* Window title */
    #request settitle "GLava"

    /* Window geometry (x, y, width, height) */
    #request setgeometry 710 286 500 500

    /* Window background color (RGB format).
       Does not work with `setopacity "xroot"` */
    #request setbg 00000000

    /* (X11 only) EWMH Window type. Possible values are:

       "desktop", "dock",   "toolbar", "menu",
       "utility", "splash", "dialog",  "normal"

       This will set _NET_WM_WINDOW_TYPE to _NET_WM_WINDOW_TYPE_(TYPE),
       where (TYPE) is the one of the window types listed (after being
       converted to uppercase).

       Alternatively, you can set this value to "!", which will cause
       the window to be unmanaged. If this is set, then `addxwinstate`
       will do nothing, but you can use "!+" and "!-" to stack on top
       or below other windows.
    */
    #request setxwintype "normal"

    /* (X11 only) EWMH Window state atoms (multiple can be specified).
       Possible values are:

       "modal", "sticky", "maximized_vert", "maximized_horz",
       "shaded", "skip_taskbar", "skip_pager", "hidden", "fullscreen",
       "above", "below", "demands_attention", "focused", "pinned"

       This will add _NET_WM_STATE_(TYPE) atoms to _NET_WM_STATE,
       where (TYPE) is one of the window states listed (after being
       converted to uppercase).

       The lines below (commented out by default) are of relevance
       if you are trying to get GLava to behave as a desktop widget
       and your WM is not correctly responding to the "desktop" value
       for `setxwintype`.
    */
    // #request addxwinstate "sticky"
    // #request addxwinstate "skip_taskbar"
    // #request addxwinstate "skip_pager"
    // #request addxwinstate "above"
    // #request addxwinstate "pinned"

    /* (X11 only) Use the XShape extension to support clicking through
       the GLava window. Useful when you want to interact with other
       desktop windows (icons, menus, desktop shells). Enabled by
       default when GLava itself is a desktop window. */
    #request setclickthrough false

    /* Audio source

       When the "pulseaudio" backend is set, this can be a number or
       a name of an audio sink or device to record from. Set to "auto"
       to use the default output device.

       When the "fifo" backend is set, "auto" is interpreted as
       "/tmp/mpd.fifo". Otherwise, a valid path should be provided. */
    #request setsource "auto"

    /* Buffer swap interval (vsync), set to '0' to prevent
       waiting for refresh, '1' (or more) to wait for the specified
       amount of frames. */
    #request setswap 1

    /* Linear interpolation for audio data frames. Drastically
       improves smoothness with configurations that yield low UPS
       (`setsamplerate` and `setsamplesize`), or monitors that have
       high refresh rates.

       This feature itself, however, will effect performance as it
       will have to interpolate data every frame on the CPU. It will
       automatically (and temporarily) disable itself if the update
       rate is close to, or higher than the framerate:

       if (update_rate / frame_rate > 0.9) disable_interpolation;

       This will delay data output by one update frame, so it can
       desync audio with visual effects on low UPS configs. */
    #request setinterpolate true

    /* Frame limiter, set to the frames per second (FPS) desired or
       simply set to zero (or lower) to disable the frame limiter. */
    #request setframerate 0

    /* Suspends rendering if a fullscreen window is focused while
       GLava is still visible (ie. on another monitor). This prevents
       rendering from interfering with other graphically intensive
       tasks.

       If GLava is minimized or completely obscured, it will not
       render regardless of this option. */
    #request setfullscreencheck false

    /* Enable/disable printing framerate every second. 'FPS' stands
       for 'Frames Per Second', and 'UPS' stands for 'Updates Per
       Second'. Updates are performed when new data is submitted
       by pulseaudio, and require transformations to be re-applied
       (thus being a good measure of how much work your CPU has to
       perform over time) */
    #request setprintframes true

    /* PulseAudio sample buffer size. Lower values result in more
       frequent audio updates (also depends on sampling rate), but
       will also require all transformations to be applied much
       more frequently (CPU intensive).

       High (>2048, with 22050 Hz) values will decrease accuracy
       (as some signals can be missed by transformations like FFT)

       The following settings (@22050 Hz) produce the listed rates:

       Sample    UPS                  Description
       - 2048 -> 43.0  (low accuracy, cheap), use with < 60 FPS
       - 1024 -> 86.1  (high accuracy, expensive), use with >= 60 FPS
       -  512 -> 172.3 (extreme accuracy, very expensive), use only
                       for graphing accurate spectrum data with
                       custom modules.

       If the framerate drops below the update rate, the update rate
       will be locked to the framerate (to prevent wasting CPU time).
       This behaviour means you can use a 1024 sample size on a 60Hz
       monitor with vsync enabled to get 60FPS and 60UPS.

       For high refresh rate monitors (120+ Hz), it's recommended to
       also stick with the 1024 sample size and use interpolation to
       smooth the data, as accuracy beyond this setting is mostly
       meaningless for visual purposes.
    */
    #request setsamplesize 1024

    /* Audio buffer size to be used for processing and shaders.
       Increasing this value can have the effect of adding 'gravity'
       to FFT output, as the audio signal will remain in the buffer
       longer.

       This value has a _massive_ effect on FFT performance and
       quality for some modules. */
    #request setbufsize 4096

    /* PulseAudio sample rate. Lower values can add 'gravity' to
       FFT output, but can also reduce accuracy. Most hardware
       samples at 44100Hz.

       Lower sample rates also can make output more choppy, when
       not using interpolation. It's generally OK to leave this
       value unless you have a strange PulseAudio configuration.

       This option does nothing when using the "fifo" audio
       backend. Instead, an ideal rate should be be configured
       in the application generating the output. */
    #request setsamplerate 22050

    /*                    ** DEPRECATED **
       Force window geometry (locking the window in place), useful
       for some pesky WMs that try to reposition the window when
       embedding in the desktop.

       This routinely sends X11 events and should be avoided. */
    #request setforcegeometry false

    /*                    ** DEPRECATED **
       Force window to be raised (focused in some WMs), useful for
       WMs that have their own stacking order for desktop windows.

       This routinely sends X11 events and should be avoided. */
    #request setforceraised false

    /*                    ** DEPRECATED **
       Scale down the audio buffer before any operations are
       performed on the data. Higher values are faster.

       This value can affect the output of various transformations,
       since it applies (crude) averaging to the data when shrinking
       the buffer. It is reccommended to use `setsamplerate` and
       `setsamplesize` to improve performance or accuracy instead. */
    #request setbufscale 1

  '';

  # # Configuration du module bars
  # home.file.".config/glava/bars.glsl".text = ''
  #   /* Module bars pour GLava */

  #   /* Nombre de barres */
  #   #define NBARS 100

  #   /* Largeur minimale d'une barre */
  #   #define BAR_MIN_HEIGHT 3

  #   /* Espace entre les barres */
  #   #define BAR_GAP 0

  #   /* Définir le rayon des barres */
  #   #define RADIUS 120

  #   /* Couleur des barres (RGB) */
  #   #define BAR_COLOR (#3366ff * ((d / 40) + 0.5))

  #   /* Alignement des barres */
  #   #define BAR_ALIGNMENT ALIGN_BOTTOM

  #   /* Dégradé de couleur du centre */
  #   #define CENTER_SMOOTH 0.3

  #   /* Mode de rendu */
  #   #define BAR_OUTLINE

  #   /* Transparence des barres */
  #   #define BAR_OUTLINE_FADE 0.4

  #   /* Largeur des contours */
  #   #define BAR_OUTLINE_WIDTH 1.5
  # '';

  # # Configuration du module circle
  # home.file.".config/glava/circle.glsl".text = ''
  #   /* Module circle pour GLava */

  #   /* Nombre de barres */
  #   #define NBARS 180

  #   /* Rayon du cercle */
  #   #define RADIUS 140

  #   /* Rotation du cercle */
  #   #define ROTATION 0

  #   /* Couleur du cercle (RGB) */
  #   #define COLOR (#3366ff * ((d / 40) + 0.5))

  #   /* Transparence des barres */
  #   #define ALPHA 0.7

  #   /* Largeur minimale d'une barre */
  #   #define BAR_MIN_HEIGHT 1

  #   /* Hauteur maximale d'une barre */
  #   #define BAR_MAX_HEIGHT 70

  #   /* Dégradé de couleur du centre */
  #   #define CENTER_SMOOTH 0.3

  #   /* Mode de rendu */
  #   #define BAR_OUTLINE

  #   /* Transparence des barres */
  #   #define BAR_OUTLINE_FADE 0.4

  #   /* Largeur des contours */
  #   #define BAR_OUTLINE_WIDTH 1.5
  # '';

  # # Configuration du module wave
  # home.file.".config/glava/wave.glsl".text = ''
  #   /* Module wave pour GLava */

  #   /* Nombre de points */
  #   #define NPOINTS 64

  #   /* Amplitude de l'onde */
  #   #define AMPLIFY 500

  #   /* Ligne de base */
  #   #define BASELINE 0

  #   /* Définir la couleur (RGB) */
  #   #define COLOR mix(#3366ff, #33ffff, clamp(d / 50, 0, 1))

  #   /* Couleur des lignes */
  #   #define LINE_COLOR COLOR

  #   /* Largeur des lignes */
  #   #define LINE_THICKNESS 2

  #   /* Transparence des lignes */
  #   #define LINE_ALPHA 0.7

  #   /* Définir le mode de rendu */
  #   #define DRAW_LINES
  # '';

  # # Configuration du module radial
  home.file.".config/glava/radial.glsl".text = ''
  /* center radius (pixels) */
  #define C_RADIUS 120
  /* center line thickness (pixels) */
  #define C_LINE 1
  /* outline color */
  #define OUTLINE @bg:#333333
  /* number of bars (use even values for best results) 160 */
  #define NBARS 180
  /* width (in pixels) of each bar*/
  #define BAR_WIDTH 2.5
  /* Amplify magnitude of the results each bar displays 150 */
  #define AMPLIFY 100
  /* How quickly the gradient transitions, in pixels */
  #define GRADIENT 95
  /* Bar color. This is a gradient by default. */
  #define COLOR @fg:mix(#a3be8c, #8fbcbb, clamp(d / GRADIENT, 0, 1))
  /* Angle (in radians) for how much to rotate the visualizer */
  #define ROTATE (PI / 2)
  /* Whether to swap left/right audio buffers, set to 1 to enable */
  #define INVERT 0
  /* Aliasing factors. Higher values mean more defined and jagged lines.
     Note: aliasing does not have a notable impact on performance, but requires
     `xroot` transparency to be enabled since it relies on alpha blending with
     the background. */
  #define BAR_ALIAS_FACTOR 1.2
  #define C_ALIAS_FACTOR 1.8
  /* Offset (Y) of the visualization */
  #define CENTER_OFFSET_Y 2
  /* Offset (X) of the visualization */
  #define CENTER_OFFSET_X 2

  /* (DEPRECATED) outline color */
  #define BAR_OUTLINE OUTLINE
  /* (DEPRECATED) outline width (in pixels, set to 0 to disable outline drawing) */
  #define BAR_OUTLINE_WIDTH 0
 '';

  # # Configuration du module graph
  # home.file.".config/glava/graph.glsl".text = ''
  #   /* Module graph pour GLava */

  #   /* Nombre de points */
  #   #define NPOINTS 64

  #   /* Amplitude du graphique */
  #   #define AMPLIFY 500

  #   /* Ligne de base */
  #   #define BASELINE 0

  #   /* Définir la couleur (RGB) */
  #   #define COLOR mix(#3366ff, #33ffff, clamp(d / 50, 0, 1))

  #   /* Couleur des lignes */
  #   #define LINE_COLOR COLOR

  #   /* Largeur des lignes */
  #   #define LINE_THICKNESS 2

  #   /* Transparence des lignes */
  #   #define LINE_ALPHA 0.7

  #   /* Définir le mode de rendu */
  #   #define DRAW_LINES
  # '';

  # # Script de démarrage de GLava
  # home.file.".local/bin/start-glava.sh" = {
  #   executable = true;
  #   text = ''
  #     #!/usr/bin/env bash

  #     # Tuer les instances existantes de GLava
  #     pkill -f glava

  #     # Attendre que les instances précédentes se terminent
  #     sleep 1

  #     # Démarrer GLava en mode fond d'écran
  #     glava --desktop &
  #   '';
  # };

  # Configuration pour le démarrage automatique
  xdg.configFile."autostart/glava.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Exec=sh -c 'sleep 10 && glava --desktop'
    Hidden=false
    NoDisplay=false
    X-GNOME-Autostart-enabled=true
    Name[en_US]=glava-startup.desktop
    Name=Glava Audio Visualizer
    Comment[en_US]=Glava Audio Visualizer
    Comment=Glava Audio Visualizer
    X-GNOME-Autostart-Delay=10
  '';
}
