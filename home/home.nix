# ./home/home.nix
{ pkgs, inputs, ... }:
{
    home.username = "lmlab";
    home.homeDirectory = "/home/lmlab";

    imports = [
      ./pkgs/fastfetch.nix
      ./pkgs/starship.nix
      ./ulauncher/default.nix
      ./wallpaper/default.nix
      ./gnome.nix
    ];

    # basic configuration of git, please change to your own
    programs.git = {
        enable = true;
        userName = "PoudaLePanda";
        userEmail = "leo.meyniel@proton.me";
        extraConfig = {
            init.defaultBranch = "main";
        };
    };

    # Configuration XDG
    xdg.enable = true;

    # GTK Configuration (gardez la même que GNOME pour la cohérence)
    gtk = {
        enable = true;
        font = {
            name = "Noto Nerd Font";
            size = 12;
        };
        iconTheme = {
            name = "Reversal-black";
            package = pkgs.reversal-icon-theme.override {
              colorVariants = [ "-black" ];
            };
        };
        cursorTheme = {
            name = "Bibata-Modern-Ice";
            package = pkgs.bibata-cursors;
            size = 24;
        };
        theme = {
            name = "Dracula";
            package = pkgs.dracula-theme;
        };
        gtk4 = {
            extraConfig = {
                gtk-application-prefer-dark-theme = true;
            };
        };
    };

    # Assurer que GTK-4 utilise le même thème avec un fichier de configuration
    xdg.configFile."gtk-4.0/gtk.css".source =
      pkgs.runCommand "gtk4-dracula-css" {} ''
        mkdir -p $out

        if [ -d "${pkgs.dracula-theme}/share/themes/Dracula/gtk-4.0" ]; then
          cp -r ${pkgs.dracula-theme}/share/themes/Dracula/gtk-4.0/* $out/
        fi

        # Si le thème Dracula n'a pas de configuration GTK4, on crée un fichier de base
        if [ ! -f "$out/gtk.css" ]; then
          echo "@import 'colors.css';" > $out/gtk.css
          echo ":root { color-scheme: dark; }" >> $out/gtk.css
        fi
      '';

    xdg.configFile."gtk-4.0/settings.ini".text = ''
      [Settings]
      gtk-application-prefer-dark-theme=1
      gtk-theme-name=Dracula
      gtk-icon-theme-name=Reversal-black
      gtk-font-name=Noto Nerd Font 12
      gtk-cursor-theme-name=Bibata-Modern-Ice
      gtk-cursor-theme-size=24
    '';

    # Cursor settings
    home.pointerCursor = {
        name = "Bibata-Modern-Ice";
        package = pkgs.bibata-cursors;
        size = 24;
    };

    # Polices communes
    home.packages = with pkgs; [
        nerd-fonts.zed-mono
        nerd-fonts.noto
        nerd-fonts.hack
        nerd-fonts.jetbrains-mono
    ];

    home.stateVersion = "24.11"; # Version de compatibilité Home Manager
}
