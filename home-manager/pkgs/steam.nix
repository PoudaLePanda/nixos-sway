{pkgs, ...}: {
  hardware.xpadneo.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Steam Remote Play.
    dedicatedServer.openFirewall = true; # Source Dedicated Server.
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];

    # Configuration du thème GTK pour Steam
    gamescopeSession.enable = true; # Optionnel pour de meilleures performances

    package = pkgs.steam.override {
      extraPkgs = pkgs:
        with pkgs; [
          libgdiplus
          keyutils
          libkrb5
          libpng
          libpulseaudio
          libvorbis
          stdenv.cc.cc.lib
          xorg.libXcursor
          xorg.libXi
          xorg.libXinerama
          xorg.libXScrnSaver
          # adwsteamgtk # bug gtk
        ];

      # Application du thème via les options de lancement
      # extraProfile = ''
      #     # Configuration pour appliquer le thème Adwaita
      #     HOME="$HOME" XDG_DATA_HOME="$HOME/.local/share" \
      #     STEAM_EXTRA_COMPAT_TOOLS_PATHS="$HOME/.steam/root/compatibilitytools.d" \
      #     $out/bin/steam -styledir ${pkgs.adwsteamgtk}/share/adwaita-for-steam/
      # '';
    };
  };

  programs.gamemode = {
    enable = true;
    enableRenice = true;
    settings = {
      general = {
        renice = 20;
      };
    };
  };

  home.packages = with pkgs; [
    (mangohud.override {lowerBitnessSupport = true;})
    gamescope
    # adwsteamgtk
  ];

  # Configuration dconf sans l'option gtk.enable
  programs.dconf.enable = true;
}
